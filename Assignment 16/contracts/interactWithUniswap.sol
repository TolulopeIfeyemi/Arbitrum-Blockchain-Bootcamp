pragma solidity ^0.8.0;

import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";

contract MyContract {
    IUniswapV3Pool pool;

    constructor(address _pool) {
        pool = IUniswapV3Pool(_pool);
    }

    function swap(uint amountIn, uint amountOutMinimum) external {
        // Your swap logic here
    }
}
