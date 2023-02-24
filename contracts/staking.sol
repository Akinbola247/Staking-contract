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
    }
    mapping(address => uint) rewardTracker;
    mapping (address=>stakerDetail) stakers;

function stake(uint _amount) public {
    require(allowedStakeToken.balanceOf(msg.sender) >= _amount, "Insufficient funds");
    require(approveFunc(_amount) >= _amount, "Approve before staking");
    allowedStakeToken.allowance(msg.sender, address(this));
    stakerDetail storage staker = stakers[msg.sender];
        if(stakers[msg.sender].stakeStatus == true){
            calculateReward();
            staker.amount += _amount;
            staker.initialStaketime = block.timestamp; 
        }else {     
       staker.amount = _amount;
       staker.initialStaketime = block.timestamp;
       staker.stakeStatus = true;
        } 
    allowedStakeToken.transferFrom(msg.sender, address(this), _amount);
    }

    function approveFunc(uint _amount) public returns(uint) {
          allowedStakeToken.approve(address(this), _amount);
          return _amount;
    }

    function calculateReward() internal {
    stakerDetail storage staker = stakers[msg.sender];
    uint _Amount = staker.amount;
    uint rewardTime = block.timestamp - staker.initialStaketime;   
    uint reward = (rewardTime * 20 * _Amount) / (SECONDS_PER_YEAR * 100);
    rewardTracker[msg.sender] += reward;  
    staker.initialStaketime = block.timestamp;
    }

    function checkreward() public returns(uint){
        calculateReward();
    uint reward = rewardTracker[msg.sender];
      emit rewardCheck(reward);
      return reward;   
    }
    function trackreward() public view returns (uint) {
        return rewardTracker[msg.sender];
    }
    function claimReward(uint _amount) public {
        calculateReward();
        
        uint claimAbleAmount = rewardTracker[msg.sender];
        require(rewardTracker[msg.sender] != 0, "You have no reward");
        require(_amount <= claimAbleAmount, "Can't withdraw more than your reward");
        require(_amount < rewardToken.balanceOf(address(this)), "check back to claim reward");
        if (_amount == claimAbleAmount){
            rewardToken.transfer(msg.sender, claimAbleAmount);
             rewardTracker[msg.sender] = 0;
        }else {
            rewardToken.transfer(msg.sender, _amount);
           uint rewardLeft = claimAbleAmount - _amount;
            rewardTracker[msg.sender] = rewardLeft;
        }
    }

function userInfo(address _user) external view returns (stakerDetail memory) {
        return stakers[_user];
    }

}