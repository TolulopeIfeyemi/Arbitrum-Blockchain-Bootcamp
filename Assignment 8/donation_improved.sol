// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract FundraiserContract {

    uint256 public immutable goal;

    uint256 public  progress;

    address payable owner;

    constructor(uint256 goal_) {
        goal = goal_;
        owner = payable(msg.sender);
    }

    function deposit() public payable  {
        progress += msg.value;
    }

    function getMyAddress() public view returns(address) {    
        return address(this);
    }

    function withdraw() public  {
        owner.transfer(address(this).balance);
    }

}
