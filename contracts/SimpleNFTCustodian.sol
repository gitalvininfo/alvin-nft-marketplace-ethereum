// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "./SimpleNFT.sol";

contract SimpleNFTCustodian {

    SimpleNFT public simpleNFT;

    function setSimpleNFTAddress(SimpleNFT instanceAddress) public {
        simpleNFT = instanceAddress;
    }

    function buyNft(uint256 nftId) public payable {
        uint salePrice = simpleNFT.getSalePrice(nftId);
        uint amountPaid = msg.value;

        require(amountPaid >= salePrice);

        address payable currentOwner = payable(simpleNFT.ownerOf(nftId));

        currentOwner.transfer(amountPaid);
        simpleNFT.transferNft(currentOwner, msg.sender, nftId);
        simpleNFT.markAsSold(nftId);
    }
}
