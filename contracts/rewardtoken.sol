// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract rewardToken is ERC20{

uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    constructor(string memory name_, string memory symbol_, uint256 amount)ERC20(name_, symbol_){
        _name = name_;
        _symbol = symbol_;
        _mint(address(this), amount * (10**decimals()));
    }
}