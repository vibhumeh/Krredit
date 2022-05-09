// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../Token/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./vouching.sol";
import "./Array/Arrayfuncs.sol";
import "./ds-math/math.sol";
import "../NFT/NFT.sol";

contract Loaning is vouching(address(this)),data,Arrayfuncs,DSMath {
using SafeMath for uint256;

//Neutron token=new Neutron(msg.sender,address(this));
uint adj=10**18; //decimal adjustment
address reciever; //the address of this contract
address allowedcon;
address allowedcon2;
address governor;
address _owner;
address treasury;
IERC20 token;
BMIERC20 _token;
IArrayfuncs calc;
uint lim;
uint cooldown;
constructor(address _treasury){
calc=IArrayfuncs(address(this));
token=IERC20(address(this));
_token=BMIERC20(address(this));
_owner=msg.sender;
treasury=_treasury;

}
//cred[Primary[msg.sender]].
modifier only_owner(){
    require(msg.sender==_owner);
_;}
function set(address tk)public{
    token=IERC20(tk);
    _token=BMIERC20(tk);
}

//function to take loan
function takeloan (uint tier) public payable{
require(sub(block.timestamp,timer[msg.sender])>=cooldown,"you are still under cooldown"); //so no loan spams
require(creditsc_c[msg.sender]>=tier**18,"you do not have a high enough credit score");
require(tier>0);
require(pending[msg.sender]==false);
uint interest;
cred[primary[msg.sender]].amount=100 * wpow((adj+adj/10),tier); //amount calc
_token.mint(msg.sender,cred[primary[msg.sender]].amount[msg.sender]);
interest=wmul(cred[primary[msg.sender]].amount[msg.sender],20*adj.div(100));//20%,interest+1% admin fee
uint x=wmul(Rrate[msg.sender],medianL[msg.sender]);
uint y=wmul(defexpo[msg.sender],Drate[msg.sender]);
//
I2[msg.sender]=wmul(sub(x,y),(interest));
principal[msg.sender]=cred[primary[msg.sender]].amount + I2;
pending[msg.sender]=true;
time[msg.sender]=block.timestamp;
if(tier==creditsc_c[msg.sender])
_match[msg.sender]==true;
}
//repayment rate calc: rrate[msg.sender]=1-Drate[msg.sender]; //R
//defult rate calc: drate=(defults[msg.sender]/(repayed[msg.sender]+defults[msg.sender]));
function returnloan() public returns(bool){
//I2 = (R*M2-D*H)*I-Ix

 require(pending[msg.sender]=true);
 if(block.timestamp.sub(time[msg.sender])>420000){
     creditsc_uc[msg.sender]=0;
     creditsc_c[msg.sender]=0;
     defults[msg.sender]+=adj;
     Dtotal[msg.sender]+=P2[msg.sender];
     if(friend[msg.sender]!=address(0)){
         creditsc_c[friend[msg.sender]]=0;
         creditsc_uc[friend[msg.sender]]=0;
         friend[msg.sender]=address(0);
     }
     creditsc_c[friend[msg.sender]]=0;
     princeD[msg.sender].push(P2[msg.sender]);
calc.sortA(princeD[msg.sender]);
medianD[msg.sender]=calc.getmedian(princeD[msg.sender]);//M1
defexpo[msg.sender]=Ltotal[msg.sender]-Dtotal[msg.sender]; //D
     return false;
 }
 else{
require(token.allowance(msg.sender,address(this))==P2[msg.sender],"please approve required amount");
uint interest=P2[msg.sender].sub(cred[primary[msg.sender]].amount[msg.sender]);
//uint burning=80;
//uint treasurym=15;
//uint ownerm=5;

//ducjdnc
require(interest+cred[primary[msg.sender]].amount[msg.sender]==P2[msg.sender],"math error");

//token.transferFrom(msg.sender,_owner,interest.mul(ownerm.div(100)));
token.transferFrom(msg.sender,treasury,interest.div(2));//mul(treasurym.div(100)));
_token.burnfrom(msg.sender,interest.div(2));//mul(burning.div(100)));
_token.burnfrom(msg.sender,amount[msg.sender]);
 //replace with burn //math to calc P2 needs to be checked
 pending[msg.sender]=false;
 creditsc_uc[msg.sender]+=adj;

 //decide if to increase credit score, (checks if under limit)
 if(creditsc_c[msg.sender]<lim && _match[msg.sender]==true){
 rounds[msg.sender]=rounds[msg.sender].add(1);
 _match[msg.sender]=false;
 //sets cooldown before next loan.
 timer[msg.sender]=block.timestamp;  //marks time when last loan was returned
 if (rounds[msg.sender]>=roundsreq[msg.sender]){
     creditsc_c[msg.sender]=creditsc_c[msg.sender].add(adj);
     if(creditsc_c[msg.sender]>10){
     friend[msg.sender]=address(0);//no link after person reaches level 10.
     }
     roundsreq[msg.sender]=roundsreq[msg.sender].add(1);
     rounds[msg.sender]=0;

 }//second if

 }//first if
 repayed[msg.sender]+=adj;
 Dtotal[msg.sender]+=P2[msg.sender];
 princeL[msg.sender].push(P2[msg.sender]);
 calc.sortA(princeL[msg.sender]);
 medianL[msg.sender]=calc.getmedian(princeL[msg.sender]);//M2
defexpo[msg.sender]=Ltotal[msg.sender]-Dtotal[msg.sender]; //D
Drate[msg.sender]=defults[msg.sender].div(repayed[msg.sender].add(defults[msg.sender]));//H

Rrate[msg.sender]=(lim.div(lim)).sub(Drate[msg.sender]);//R
 return true;


 }//outermost if/else

}
function freemoney() public  payable{
    _token.mint(msg.sender,(1000*adj));
}
/*function setgovernor(address _governor) public only_owner returns(bool){

    governor=_governor;
    return true;
}// set governor contract*/
function increment(address pardonee)public{
    //require(msg.sender==allowedcon||msg.sender==allowedcon2,"you do not have permission to do this action.");
    creditsc_c[pardonee]=1;
    creditsc_uc[pardonee]=1;

}


}
