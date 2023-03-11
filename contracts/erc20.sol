// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DAIToken is ERC20{
address owner;
uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    constructor(string memory name_, string memory symbol_, uint256 amount)ERC20(name_, symbol_){
        owner = msg.sender;
        _name = name_;
        _symbol = symbol_;
        _mint(address(this), amount * (10**decimals()));
    }

function minting(address receiver, uint _amount) public returns(bool) {
    require(msg.sender == owner, "not authorized");
    _mint(receiver, _amount * (10**decimals()));
    return true;
}




}