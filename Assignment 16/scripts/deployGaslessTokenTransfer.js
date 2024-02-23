const hre = require("hardhat");

async function main() {
  const gaslessTokenTransfer = await hre.ethers.deployContract(
    "GaslessTokenTransfer"
  );

  gaslessTokenTransfer.waitForDeployment();

  console.log(
    "the contract has been deployed to " + gaslessTokenTransfer.target
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

// the contract has been deployed to 0x47339086B9AA13a0b42A6613bA2b7078C68DF924
