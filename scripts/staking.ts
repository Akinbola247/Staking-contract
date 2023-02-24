import { ethers } from "hardhat";

async function main() {
    const DAI = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
   const DAIAddress = "0x748dE14197922c4Ae258c7939C7739f3ff1db573";
//   const [owner] = await ethers.getSigners()

//deploy reward token contract
const RewardToken = await ethers.getContractFactory("rewardToken");
const rewardToken = await RewardToken.deploy("web", "CVIII", 500000000);
await rewardToken.deployed();
console.log(`reward Token deployed at ${rewardToken.address}`);


//deploy staking contract
const Staking = await ethers.getContractFactory("staking");
const staking = await Staking.deploy(rewardToken.address, DAI);
await staking.deployed();
console.log(`your staking contract is deployed at ${staking.address}`);

//impersonating real account
const helpers = require("@nomicfoundation/hardhat-network-helpers");
const address = DAIAddress;
await helpers.impersonateAccount(address);
const impersonatedSigner = await ethers.getSigner(address);

//interat with dai contract
const dai = await ethers.getContractAt("IDAI", DAI);
const balance = await dai.balanceOf(impersonatedSigner.address);
console.log(`balance is ${balance}`);

//interacting with staking

const stakeDai = ethers.utils.parseEther("50");
const approval = await dai.connect(impersonatedSigner).approve(staking.address, stakeDai);

const allowance = await dai.allowance(DAIAddress, staking.address);
const staker1 = await staking.connect(impersonatedSigner).stake(stakeDai);
const userInfo1 = await staking.connect(impersonatedSigner).userInfo(impersonatedSigner.address);
console.log(await userInfo1);
const trackRward1 = await staking.connect(impersonatedSigner).trackreward();
console.log(trackRward1);
// const event1 = await checkreward1.wait();
//     console.log(event1.events[0].event);

await ethers.provider.send("evm_mine", [1708037999]);
const checkreward1 = await staking.connect(impersonatedSigner).checkreward();
const userInfo2 = await staking.connect(impersonatedSigner).userInfo(impersonatedSigner.address);
console.log(await userInfo2);
const trackRward = await staking.connect(impersonatedSigner).trackreward();
console.log(trackRward);

// const checkreward2 = await staking.connect(impersonatedSigner).checkreward();
// const event = await checkreward2.wait();
//     console.log(await event.events[0].event);

}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});