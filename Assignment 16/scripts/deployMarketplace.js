const hre = require("hardhat");

async function main() {
  const marketplace = await hre.ethers.deployContract("Marketplace");

  marketplace.waitForDeployment();

  console.log("the contract has been deployed to " + marketplace.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

// the contract has been deployed to 0x5ab5c273Ff18269F65F4797aE39E166E616a59Bc
