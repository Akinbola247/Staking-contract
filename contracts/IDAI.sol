// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface IDAI {
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function mint(address receiver, uint _amount) external returns (bool);
}