// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("Sherry's first NFT", "NFT") {}

    function mintNFT(
        address recipient,
        string memory tokenURI
    ) public onlyOwner returns (uint256) {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}

/**
 在第 9-27 行中，我们创建了自定义的 NFT 智能合约，它出奇地简短--只包含一个计数器、一个构造函数和一个函数！这要归功于我们继承的 OpenZepplin 合约，它实现了创建 NFT 所需的大部分方法，如 ownerOf（返回 NFT 的所有者）和 transferFrom（转移 NFT 的所有权）。

在第 13 行，你会发现我们向 ERC721 构造函数传递了两个字符串："MyNFT "和 "NFT"。第一个变量是智能合约的名称，第二个变量是其符号。你可以按照自己的意愿为每个变量命名！

最后，从第 15 行开始，我们将使用函数 mintNFT()来铸造一个 NFT！你会注意到这个函数接收了两个变量：

地址接收者指定将接收新铸币的 NFT 的地址
string memory tokenURI 是一个字符串，应解析为描述 NFT 元数据的 JSON 文档。NFT 的元数据使其栩栩如生，允许其拥有更多属性，如名称、描述、图像和其他属性。在本教程的第二部分，我们将介绍如何配置这些元数据。
mintNFT 调用继承的 ERC721 库中的一些方法，最终返回一个数字，代表新铸币 NFT 的 ID。
 */
