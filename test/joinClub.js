const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('Proof of Membership Access', function () {
    before(async function () {
        this.POAP = await ethers.getContractFactory('ProofOfAccess')
    });

    this.beforeEach(async function () {
        this.POAP = await this.POAP.deploy();
        await this.POAP.deployed();
    });

    // Join the club
    it('Joins a club and retrieves the tokenId', async function () {
        const _joiinFee = ethers.utils.parseUnits('0.01', 'ether')
        const receipt = await this.POAP.joinClub({
            value: _joiinFee
        })

        // Test the transferSingle event
      
    })
})