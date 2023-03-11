import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import dotenv from "dotenv"
dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.9",
  networks: {
    hardhat: {
      forking: {
        url: "https://eth-mainnet.g.alchemy.com/v2/xypdsCZYrlk6oNi93UmpUzKE9kmxHy2n",
      }
    },
    // goerli: {
    //   url: process.env.GOERLI_RPC,
    //   //@ts-ignore
    //   accounts: [process.env.PRIVATE_KEY]
    // }
  }

};

export default config;
