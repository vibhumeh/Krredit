// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
contract data{
    struct Credit_card{
//taking loan
uint creditsc_c;
uint creditsc_uc; //
uint _match;

uint amount;
//paying loan
uint pending;
uint Ldate;
uint time;
//DEBT CALC
uint[] princeD;
uint[] princeL;
uint medianL;
uint medianD;

}
mapping (uint256=>Credit_card) cred;
mapping (address =>uint) Primary;
}

contract Credit is ERC721, ERC721Burnable, Ownable, data{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Credit", "CRD") {}


function setPrimary(uint tokenId) public returns(bool){
require(_isApprovedOrOwner(_msgSender(),tokenId),"caller is not owner nor approved");
Primary[msg.sender]=tokenId;
return true;
}

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }
    function burn(uint256 tokenId) public override virtual {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721Burnable: caller is not owner nor approved");
        cred[tokenId]=cred[0];
        _burn(tokenId);
        if(Primary[_msgSender()]==tokenId)
        Primary[_msgSender()]=0;
    }

}
