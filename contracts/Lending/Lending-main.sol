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
uint burner=80*adj;
uint rate=20;

//Neutron token=new Neutron(msg.sender,address(this));
uint adj=10**18; //decimal adjustment
address reciever; //the address of this contract
address allowedcon;
address allowedcon2;
address governor;
address _owner;
address treasury;
_IERC20 token;
IArrayfuncs calc;
uint lim;
uint cooldown;
mapping (address=>uint256) I2;
constructor(address _treasury){
_owner=msg.sender;
treasury=_treasury;

}
//cred[Primary[msg.sender]].
modifier only_owner(){
    require(msg.sender==_owner);
_;}
function set(address tk)public{
    token=_IERC20(tk);
}

//function to take loan
function takeloan (uint tier) public payable{
require(Primary!=0,"please confirm your primary credit card");
require(sub(block.timestamp,cred[Primary[msg.sender]].timer)>=cooldown,"you are still under cooldown"); //so no loan spams
require(cred[Primary[msg.sender]].creditsc_c>=tier*adj,"you do not have a high enough credit score");
require(tier>0);
require(!pending,"You have already taken a loan, please re-pay to take a new loan");
uint interest;
cred[Primary[msg.sender]].amount=100 * wpow((adj+adj/10),tier); //amount calc
token.mint(msg.sender,cred[Primary[msg.sender]].amount);
interest=wmul(cred[Primary[msg.sender]].amount,mul(rate,div(adj,100)));//20%,interest+1% admin fee
uint x=wmul(Rrate,medianL);
uint y=wmul(defexpo,Drate);
//
I2=wmul(sub(x,y),(interest));
principal=cred[Primary[msg.sender]].amount + I2;
pending=true;
time=block.timestamp;
if(tier==creditsc_c)
_match==true;
}
//repayment rate calc: rrate=1-Drate; //R
//defult rate calc: drate=(defults/(repayed+defults));
function returnloan() public returns(bool){
//I2 = (R*M2-D*H)*I-Ix

 require(pending=true);
 P2=cred[Primary[msg.sender]].amount+I2;
 if(block.timestamp.sub(time)>420000){
     cred[Primary[msg.sender]].creditsc_uc=0;
     cred[Primary[msg.sender]].creditsc_c=0;
     cred[Primary[msg.sender]].defults+=adj;
     cred[Primary[msg.sender]].Dtotal+=P2;
     if(friend!=address(0)){
         cred[Primary[friend]].creditsc_c=0;
         cred[Primary[friend]].creditsc_uc[friend]=0;
         friend=address(0);
     }
     creditsc_c[friend]=0;
     cred[Primary[msg.sender]].princeD.push(P2);
sortA(cred[Primary[msg.sender]].princeD);
cred[Primary[msg.sender]].medianD=getmedian(princeD);//M1
cred[Primary[msg.sender]].defexpo=sub(cred[Primary[msg.sender]].Ltotal,cred[Primary[msg.sender]].Dtotal); //D
     return false;
 }
 else{
require(token.allowance(msg.sender,address(this))==P2,"please approve required amount");

uint interest=I2;
uint burning=burner;
uint treasurym=sub(mul(100,adj),burning);
//uint ownerm=5;


require(interest+cred[Primary[msg.sender]].amount==P2,"math error");

token.transferFrom(msg.sender,_owner,interest.mul(ownerm.div(100)));
token.transferFrom(msg.sender,treasury,interest.div(2));//mul(treasurym.div(100)));
token.burnfrom(msg.sender,interest.div(2));//mul(burning.div(100)));
token.burnfrom(msg.sender,amount);

 //replace with burn //math to calc P2 needs to be checked
 cred[Primary[msg.sender]].pending=false;
 cred[Primary[msg.sender]].creditsc_uc+=adj;

 //decide if to increase credit score, (checks if under limit)
 if(creditsc_c<lim && _match==true){
 cred[Primary[msg.sender]].creditsc_c=add(cred[Primary[msg.sender]].creditsc_c,adj);
 cred[Primary[msg.sender]]._match=false;
 //sets cooldown before next loan.
}
 timer=block.timestamp;  //marks time when last loan was returned


 //second if

 //first if
 cred[Primary[msg.sender]].repayed+=adj;
 cred[Primary[msg.sender]].Dtotal+=P2;
 cred[Primary[msg.sender]].princeL.push(P2);
 sortA(princeL);
 cred[Primary[msg.sender]].medianL=getmedian(cred[Primary[msg.sender]].princeL);//M2
cred[Primary[msg.sender]].defexpo=sub(cred[Primary[msg.sender]].Ltotal,cred[Primary[msg.sender]].Dtotal); //D
uint x=add(cred[Primary[msg.sender]].repayed,cred[Primary[msg.sender]].defults);
cred[Primary[msg.sender]].Drate=wdiv(cred[Primary[msg.sender]].defults,x);//H

cred[Primary[msg.sender]].Rrate=sub(1,Drate]);//R
 return true;


 }//outermost if/else

}
function freemoney() public  payable{
    token.mint(msg.sender,(1000*adj));
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
