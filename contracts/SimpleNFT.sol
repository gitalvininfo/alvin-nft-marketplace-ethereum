// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract SimpleNFT is ERC721URIStorage {
    using Counters for Counters.Counter;

    Counters.Counter public _tokenIds;
    NFTSale[] public _listed;

    struct NFTSale {
        uint256 id;
        uint price;
        bool isForSale;
    }

    constructor() ERC721("SimpleNFT", "SNFT") {

    }

    function mintNFT(string memory tokenURI, uint price, address custodian) public {
        uint newItemId = _tokenIds.current();

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, tokenURI);
        approve(custodian, newItemId);

        NFTSale memory sale = NFTSale(newItemId, price, true);
        _listed.push(sale);

        _tokenIds.increment();
    }

}
