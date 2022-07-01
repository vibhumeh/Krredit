// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "../Lending/ILoaning.sol";

contract Credit is ERC721, ERC721Burnable, Ownable{
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Credit", "CRD") {}
/*event tester(uint myprime);
function primaryOf(address a)public returns(bool){
  Primary[a]=1;
  return true;
}
function setPrimary(uint tokenId,address whose)public {
//require(_isApprovedOrOwner(_msgSender(),tokenId),"setPrimary: caller is not owner nor approved");

//require(!cred[Primary[msg.sender]].pending,"you cannot change your primary when you are in debt");
Primary[msg.sender]=1;
emit tester(Primary[msg.sender]);

}*/
function TokenIdCounterLatest() public view returns(uint256) {
  return _tokenIdCounter.current();
}
ILoaning ln;
function lendingcon(address loaning) public {
  ln=ILoaning(loaning);
}
    function safeMint(address to) public{ //onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
//change modifier
    }
    function burn(uint256 tokenId) public override virtual {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721Burnable: caller is not owner nor approved");
      ln.Reset_credit(tokenId);
        _burn(tokenId);
        if(ln.Prime(msg.sender)==tokenId)
        ln.Prime(msg.sender,0);
    }

}
