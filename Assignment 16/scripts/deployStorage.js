const hre = require("hardhat");

async function main() {
  const storage = await hre.ethers.deployContract("Storage", [1000]);

  storage.waitForDeployment();

  console.log("the contract has been deployed to " + storage.target);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

// the contract has been deployed to 0x4794845Fc7D9ce29caec074A52186a158d0E7834
