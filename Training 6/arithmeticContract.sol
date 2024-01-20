// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract arithmeticContract {
    function isOdd(uint256 number) public pure returns (bool) {
        return number % 2 != 0;
    }

    function isEven(uint256 number) public pure returns (bool) {
        return number % 2 == 0;
    }

    function calculateMSB(uint256 number) public pure returns (uint8) {
        require(number > 0, "Number must be greater than 0");
        
        // Find the position of the most significant bit
        uint8 msbPosition;
        while (number > 0) {
            number >>= 1;
            msbPosition++;
        }

        return msbPosition;
    }
}