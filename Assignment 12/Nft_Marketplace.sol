// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMarketplace is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct NFT {
        uint256 id;
        string uri;
        uint256 price;
        bool isForSale;
    }

    mapping(uint256 => NFT) public nfts;
    address public implementation;

    constructor() ERC721("NFT Marketplace", "NFTM") {}

    function setImplementation(address implementation_) external onlyOwner {
        implementation = implementation_;
    }

    fallback() external payable {
        (bool success, ) = implementation.delegatecall(msg.data);
        require(success, "Failed to delegate call");
    }
}
