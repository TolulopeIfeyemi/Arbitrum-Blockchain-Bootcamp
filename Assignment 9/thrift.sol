//  Implement a thrift contract.


// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Thrift {
    uint256 public contributionAmount;
    uint256 public totalContributors;
    uint256 public totalContributions;
    uint256 public nextPayoutIndex;

    struct Contributor {
        bool hasContributed;
        bool hasReceivedPayout;
    }

    mapping(address => Contributor) public contributors;

    constructor(uint256 _contributionAmount, uint256 _totalContributors) {
        contributionAmount = _contributionAmount;
        totalContributors = _totalContributors;
    }

    function contribute() public payable {
        require(msg.value == contributionAmount, "Incorrect contribution amount");
        require(!contributors[msg.sender].hasContributed, "Already contributed");

        contributors[msg.sender].hasContributed = true;
        totalContributions += msg.value;

        if (totalContributions == contributionAmount * totalContributors) {
            payout();
        }
    }

    function payout() private {
        require(totalContributions == contributionAmount * totalContributors, "Not enough contributions");

        address payable recipient = payable(payable(address(this)).balance);
        recipient.transfer(totalContributions);
        totalContributions = 0;
        nextPayoutIndex++;
    }
}
