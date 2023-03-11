import { ethers } from "hardhat";

async function main() {
  //   const DAI = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
  //  const DAIAddress = "0x748dE14197922c4Ae258c7939C7739f3ff1db573";
  const [owner] = await ethers.getSigners()

//deploy reward token contract
// const RewardToken = await ethers.getContractFactory("rewardToken");
// const rewardToken = await RewardToken.deploy("web", "CVIII", 50000000000);
// await rewardToken.deployed();
// console.log(`reward Token deployed at ${rewardToken.address}`);


//deploy token to stake
// const DaiToken = await ethers.getContractFactory("DAIToken");
// const daiToken = await DaiToken.deploy("DAItoken", "DAIT", 500000000);
// await daiToken.deployed();
// console.log(`dai Token deployed at ${daiToken.address}`);


//deploy staking contract
// const Staking = await ethers.getContractFactory("staking");
// const staking = await Staking.deploy("0xFA31a97c9D3d1209377e757f44C6E5D6C730C801", "0x5e4a42c567cA56eA429d87b0EDB8d438c329B7B9");
// await staking.deployed();
// console.log(`your staking contract is deployed at ${staking.address}`);

const DaiINter = await ethers.getContractAt("IDAI","0xFA31a97c9D3d1209377e757f44C6E5D6C730C801");
const stakeDai = ethers.utils.parseEther("5000");
const approval = await DaiINter.connect(owner).approve("0xf3D1b9E397B501E8A23ee0d1EF1980a39262C3c4", stakeDai);


// const interact = await ethers.getContractAt("Istake", "0xf3D1b9E397B501E8A23ee0d1EF1980a39262C3c4")
// await interact.stake(ethers.utils.parseEther("0.001"));
console.log("working");
//impersonating real account
// const helpers = require("@nomicfoundation/hardhat-network-helpers");
// const address = DAIAddress;
// await helpers.impersonateAccount(address);
// const impersonatedSigner = await ethers.getSigner(address);

//interat with dai contract
// const dai = await ethers.getContractAt("IDAI", daiToken.address);
// const amountToMint = ethers.utils.parseEther('200')
// const mint = await daiToken.connect(owner).minting(owner.address, 2000)
// const mint1 = await daiToken.connect(owner).minting(staking.address, amountToMint)
// const mint2 = await rewardToken.connect(owner).minting(staking.address, amountToMint)
// const balance = await daiToken.balanceOf(owner.address);
// const balance1 = await rewardToken.balanceOf(staking.address);
// const balance2 = await daiToken.balanceOf(staking.address);
// console.log(`balance of owner is ${balance}`);
// console.log(`balance contract dai is ${balance1}`);
// console.log(`balance contract reward is ${balance2}`);

//interacting with staking

// const stakeDai = ethers.utils.parseEther("5");
// const approval = await daiToken.connect(owner).approve(staking.address, stakeDai);
// const approval2 = await rewardToken.connect(owner).approve(staking.address, stakeDai);

// const allowance = await daiToken.allowance(owner.address, staking.address);
// const staker1 = await staking.connect(owner).stake(stakeDai);
// const stakedBalance1 = await daiToken.balanceOf(owner.address);
// console.log(`balance after stake ${stakedBalance1}`);
// const userInfo1 = await staking.connect(owner).userInfo(owner.address);
// console.log(`user information after staking ${userInfo1}`);

// const event1 = await checkreward1.wait();
//     console.log(event1.events[0].event);



// await ethers.provider.send("evm_mine", [1708037999]);
// const calculatedReward = await staking.connect(owner).calculateReward();
// console.log(`calculated reward is ${calculatedReward}`);
// const userInfo2 = await staking.connect(owner).userInfo(owner.address);
// console.log(`user information after wrapping time ${userInfo2}`);


// const withdraw = await staking.connect(owner).withdrawStaking();
// const stakedBalance = await daiToken.balanceOf(owner.address);
// const rewardbalance = await rewardToken.balanceOf(owner.address);
// console.log(`reward balance after withdraw ${rewardbalance}`);
// console.log(`stake balance after withdrawal ${stakedBalance}`)


// const checkreward2 = await staking.connect(impersonatedSigner).checkreward();
// const event = await checkreward2.wait();
//     console.log(await event.events[0].event);

}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});