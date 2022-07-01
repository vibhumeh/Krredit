// SPDX-License-Identifier: MIT
//vouchee -blacklisted person who is being vouched for by a high level person.
pragma solidity 0.8.7;
import "../NFT/NFT.sol";
import "./ILoaning.sol";

contract data{
struct  Credit_card {
//taking loan
uint creditsc_c;
uint creditsc_uc; //
bool _match;
uint principal;
uint amount;
//paying loan
bool pending;
uint Ldate;
uint time;
uint timer;
//DEBT CALC
uint defults;
uint repayed;
uint Ltotal;
uint Dtotal;
uint defexpo;
uint Drate;
uint Rrate;
uint[] princeD;
uint[] princeL;
uint medianL;
uint medianD;

}
/*event Set_Primary(uint256 token_ID);
require(_isApprovedOrOwner(_msgSender(),tokenId),"setPrimary: caller is not owner nor approved");
mapping (uint256=>Credit_card) cred;
mapping (address =>uint)  Primary;

function setPrimary(uint tokenId)public {


require(!cred[Primary[msg.sender]].pending,"you cannot change your primary when you are in debt");
Primary[msg.sender]=tokenId;
emit Set_Primary(Primary[msg.sender]);

}*/
mapping (uint256=>Credit_card) cred;
mapping (address =>uint)  Primary;
}

//vouch contract
contract vouching is data{
    //friend is the link between the vouchee and the vouch giver so you know who to penalise incase of second defult
    mapping (address=>address) public friend;
    //banking is the main krredit bank contract address
    ILoaning loans;
    address bank;
    uint adj;
        constructor(address banking){
          bank=banking;
          loans=ILoaning(bank);
          adj=10**18;
        }
    //vouch function begins here, it only takes address of the vouch reciever.
    function vouch(address vouchee) public returns (bool success){
        //person cannot have a pending loan.
        require(cred[Primary[msg.sender]].pending==false);

        //checks if his level is high enough (6 is dummy num)
        require(cred[Primary[msg.sender]].creditsc_c>=6,"your level is too low");
        //makes sure the receiver lev is at 0 so this feature cannot increase level of non-zero ppl
        require(cred[Primary[vouchee]].creditsc_c==0,"vouchee level is not 0");
        //tags person who vouched for vouchee
        friend[vouchee]=msg.sender;
        //increases level and makes vouchee eligible for loans again
        loans.increment(vouchee,adj);
        return true;
    }
}
