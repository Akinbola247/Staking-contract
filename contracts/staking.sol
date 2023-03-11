// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract staking {
    IERC20 rewardToken;
    IERC20 allowedStakeToken;

    constructor(IERC20 _rewardToken, IERC20 _allowedStakeToken){
        rewardToken = _rewardToken;
        allowedStakeToken = _allowedStakeToken;

    }
    event rewardCheck (uint balance);
    uint256 constant SECONDS_PER_YEAR = 31536000;
    struct stakerDetail{
        uint amount;
        uint initialStaketime;
        bool stakeStatus;
        uint tokenEarned;
    }

    mapping (address=>stakerDetail) stakers;

function stake(uint _amount) public {
    stakerDetail memory stakerMem = stakers[msg.sender];
        if(stakerMem.stakeStatus == true){
            uint _Amount = stakerMem.amount;
            uint rewardTime = block.timestamp - stakerMem.initialStaketime;   
            uint reward = (rewardTime * 5 * _Amount) / (SECONDS_PER_YEAR * 100); 
            stakerMem.initialStaketime = block.timestamp;
            stakerMem.tokenEarned += reward;
            stakerMem.amount += _amount;
            stakerMem.initialStaketime = block.timestamp; 
            stakers[msg.sender] = stakerMem;
        }else {     
       stakerMem.amount = _amount;
       stakerMem.initialStaketime = block.timestamp;
       stakerMem.stakeStatus = true;
       stakers[msg.sender] = stakerMem;
        } 
    allowedStakeToken.transferFrom(msg.sender, address(this), _amount);
    }

    function calculateReward() public view returns(uint){
    stakerDetail memory stakerMem = stakers[msg.sender];
    uint _Amount = stakerMem.amount;
    uint rewardTime = block.timestamp - stakerMem.initialStaketime;   
    uint reward = (rewardTime * 5 * _Amount) / (SECONDS_PER_YEAR * 100); 
        return(reward);
    }

    
    function claimReward(uint _amount) public {  
    stakerDetail memory stakerMem = stakers[msg.sender];
        uint _Amount = stakerMem.amount;
        uint rewardTime = block.timestamp - stakerMem.initialStaketime;   
        uint reward = (rewardTime * 5 * _Amount) / (SECONDS_PER_YEAR * 100); 
        stakerMem.initialStaketime = block.timestamp;
        stakerMem.tokenEarned += reward;
        uint claimAbleAmount = stakerMem.tokenEarned;
        require( claimAbleAmount != 0, "You have no reward");
        require(_amount <= claimAbleAmount, "Can't withdraw more than your reward");
        require(_amount < rewardToken.balanceOf(address(this)), "check back to claim reward");
        if (_amount == claimAbleAmount){
            rewardToken.transfer(msg.sender, claimAbleAmount);
             stakerMem.tokenEarned = 0;
            stakers[msg.sender].tokenEarned = stakerMem.tokenEarned;
        }else {
            rewardToken.transfer(msg.sender, _amount);
           uint rewardLeft = claimAbleAmount - _amount;
            stakerMem.tokenEarned = rewardLeft;
            stakers[msg.sender].tokenEarned = stakerMem.tokenEarned;
        }
    }

    function withdrawStaking()public {
        stakerDetail memory stakerMem = stakers[msg.sender];
        uint _Amount = stakerMem.amount;
        uint rewardTime = block.timestamp - stakerMem.initialStaketime;   
        uint reward = (rewardTime * 20 * _Amount) / (SECONDS_PER_YEAR * 100); 
        stakerMem.initialStaketime = block.timestamp;
        stakerMem.tokenEarned += reward;
       uint staked = stakerMem.amount;
       uint rewardEarned = stakerMem.tokenEarned;
       require(reward < rewardToken.balanceOf(address(this)), "check back to withdraw");
       require(staked < allowedStakeToken.balanceOf(address(this)), "check back to withdraw");
       allowedStakeToken.transfer(msg.sender, staked);
       rewardToken.transfer(msg.sender, rewardEarned);
       stakerMem.amount = 0;
       stakerMem.initialStaketime = 0;
       stakerMem.stakeStatus = false;
       stakerMem.tokenEarned = 0;
       stakers[msg.sender] = stakerMem;
    }

function userInfo(address _user) external view returns (stakerDetail memory) {
        return stakers[_user];
    }


}