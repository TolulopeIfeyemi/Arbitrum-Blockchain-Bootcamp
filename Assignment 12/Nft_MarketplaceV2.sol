// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMarketplaceV2 is NFTMarketplace {
    function mint(string memory tokenURI, uint256 price) public onlyOwner {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        nfts[newItemId] = NFT(newItemId, tokenURI, price, true);
    }

    function buy(uint256 tokenId) public payable {
        require(msg.value >= nfts[tokenId].price, "Not enough Ether");
        require(nfts[tokenId].isForSale, "NFT not for sale");
        nfts[tokenId].isForSale = false;
        payable(owner()).transfer(msg.value);
        _transfer(owner(), msg.sender, tokenId);
    }
}
