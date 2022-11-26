// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ProofOfAccess is ERC1155, Ownable, Pausable, ERC1155Supply {
    uint256 public maxSupply = 10;
    uint256 public joinFee = 0.01 ether;
    string public name;
    mapping(address => bool) public hasJoined;


    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC1155("ipfs://QmaB1MVgpDW38UJtgGUFUY48oXJoChA89ine28YfL1Dn7m/") {
        setName("TechBaze Club Proof of Access Collection");
    }

    function joinClub() public payable {
        require(!hasJoined[msg.sender], "You have already joined the club");
        require(msg.value == joinFee, "Not enough fee to join the club");
        uint256 currentTokenId = _tokenIds.current();
        uint256 tokenId = currentTokenId + 1;

        require(tokenId + 1 < maxSupply, "Sorry! You can not join the club again");

        _mint(msg.sender, tokenId, 1, "");
        _tokenIds.increment();
        hasJoined[msg.sender] = true;
    }

     function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function uri(uint256 _id)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(exists(_id), "URI: Non-existent token");

        return
            string(
                abi.encodePacked(super.uri(_id), Strings.toString(_id), ".json")
            );
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function setName(string memory _name) public onlyOwner {
        name = _name;
    }

    function mintBatch(uint256[] memory ids, uint256[] memory amounts)
        public
        onlyOwner
    {
        _mintBatch(msg.sender, ids, amounts, "");
    }

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) internal override(ERC1155, ERC1155Supply) whenNotPaused {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }

    function withdraw(address _addr) external onlyOwner {
        uint256 balance = address(this).balance;
        payable(_addr).transfer(balance);
    }
}
