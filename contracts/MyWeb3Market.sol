
// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyWeb3Market is Ownable(msg.sender) {
    struct Item {
        uint id;
        address nftAddr;
        uint256 tokenId;
        address payable seller;
        uint256 price;
    }

    uint256 private itemId;
    mapping(uint => Item) private idToItem;

    event ItemListed(
        uint indexed id,
        address indexed nftAddr,
        uint256 indexed tokenId,
        address seller,
        uint256 price
    );

    function listItem(
        address nftAddr,
        uint256 tokenId,
        uint256 price
    ) external {
        require(price > 0, "Price must be greater than 0");
        IERC721(nftAddr).transferFrom(msg.sender, address(this), tokenId);
        uint256 newItemId = itemId++;
        idToItem[newItemId] = Item(newItemId, nftAddr, tokenId, payable(msg.sender), price);
        emit ItemListed(newItemId, nftAddr, tokenId, msg.sender, price);
    }

    function buyItem(uint id) external payable {
        Item memory item = idToItem[id];
        require(msg.value == item.price, "Incorrect price sent");
        IERC721(item.nftAddr).transferFrom(address(this), msg.sender, item.tokenId);
        item.seller.transfer(msg.value);
        delete idToItem[id];
    }

    function viewItem(uint id) external view returns (Item memory) {
        return idToItem[id];
    }

    function mintNFT(
    address nftAddr,
    uint256 tokenId,
    address to
) external onlyOwner {
    IERC721(nftAddr).safeTransferFrom(msg.sender, to, tokenId);
}
}