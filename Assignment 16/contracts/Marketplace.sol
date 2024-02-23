// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Marketplace is ERC721URIStorage, Ownable {
    uint256 private _currentTokenId = 0;

    struct NFT {
        uint256 id;
        string uri;
        uint256 price;
        bool isForSale;
    }

    mapping(uint256 => NFT) public nfts;

    constructor() ERC721("NFT Marketplace", "NFTM") Ownable(msg.sender) {}

    function _incrementTokenId() private {
        _currentTokenId++;
    }

    function mint(string memory tokenURI, uint256 price) public onlyOwner {
        _incrementTokenId();
        uint256 newItemId = _currentTokenId;
        _mint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        nfts[newItemId] = NFT(newItemId, tokenURI, price, true);
    }

    function buy(uint256 tokenId) public payable {
        require(msg.value >= nfts[tokenId].price, "Not enough Ether");
        require(nfts[tokenId].isForSale, "NFT not for sale");
        nfts[tokenId].isForSale = false;
        address currentOwner = ownerOf(tokenId);
        payable(currentOwner).transfer(msg.value);
        _transfer(currentOwner, msg.sender, tokenId);
    }
}
