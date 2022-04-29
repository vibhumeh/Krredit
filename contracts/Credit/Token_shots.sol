pragma solidity ^0.8.7;
import "../Token/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./credit.sol"

contract snapper is data{
  mapping(address=> uint256) public credearning;
  mapping(address=>uint) public LastTimeOfClaim;
  constructor(address _token){
    BMIERC20 token= BMIERC20(_token);
    IERC20 token_=IERC20(_token);
  }
  uint adj= 10**18;

  function sqrt(uint x) returns (uint y) {
      uint z = (x + 1) / 2;
      y = x;
      while (z < y) {
          y = z;
          z = (x / z + z) / 2;
      }
  } //used in calculation of reward




  function calculate() public returns(uint256){
require(LastTimeOfClaim!=0,"you do not own a credit card")
uint avg;
uint ETime=block.timestamp-LastTimeOfClaim[msg.sender];
require(ETime>4200, "you need to wait longer before claiming your reward");
avg=token.sum(msg.sender)/ETiime;
if(avg<=10000)
credearning[msg.sender]=(avg/2000)*((1-avg/token_.totalsupply())**(cred[Primary[msg.sender]].creditsc_c/adj)));
else
{credearning[msg.sender]=sqrt((avg/2000)*((1-avg/token_.totalsupply())**(cred[Primary[msg.sender]].creditsc_c/adj)));
if(avg<10**5)
credearning+=5+credearning/10
}
return credearning[msg.sender];
  }
  function redeem() public returns(bool){
cred[Primary[msg.sender]].creditsc_c+=calculate();
return true;
  }
}
