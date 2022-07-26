require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan")
require("dotenv").config();
require("hardhat-gas-reporter")
require("solidity-coverage")
require("hardhat-deploy")


/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    rinkeby:{
      url: process.env.RPC_URL,
      accounts: [process.env.PRIVATE_KEY],
      chainId: 4
    },
    localhost: {
      url: "http://127.0.0.1:8545/",
      chainId: 31337
    }
  },
  solidity: {
    compilers: [
      {version: "0.8.9"},
      {version: "0.6.6"}
    ]
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY
  },
  gasReporter: {
    enabled: true,
    outputFile: "gas-report.txt",
    noColors: true,
    currency: "USD",
    coinmarketcap: process.env.COINMARKETCAP_API_KEY,
    token: "MATIC"
  },
  namedAccounts: {
    deployer: {
      default: 0,
      1:0
    }
  }
};
