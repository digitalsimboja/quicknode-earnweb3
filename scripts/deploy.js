// Import ethers
const { ethers } = require("hardhat")

async function main() {
  const poapContract = await ethers.getContractFactory("ProofOfAccess");

  const deployedPoapContract = await poapContract.deploy();

  await deployedPoapContract.deployed();

  console.log("Proof of Membership Contract Address: ", deployedPoapContract.address)
}

// Call the main function and catch if there is any error
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });