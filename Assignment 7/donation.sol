// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Donation {

    address owner;
    uint256 donation_fund;

constructor(){
    owner = msg.sender;
}

function deposit(uint256 amount) public {
    donation_fund += amount;
} 

function withdrawal() public {

}

}