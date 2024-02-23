require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-verify");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  networks: {
    arbitrumSepolia: {
      url: "https://sepolia-rollup.arbitrum.io/rpc",
      chainId: 421614,
      accounts: [
        "255ef424ac1298a002c2d3f02c0fbba647043184fe7c81f4f9c726deac3d9d14",
      ],
    },
  },
  etherscan: {
    apiKey: {
      arbitrumSepolia: "T6CRD1P9S9DCB9CYQYZ1BF3RVUWB6JG2D6",
    },
  },
  sourcify: {
    enabled: true,
  },
};
