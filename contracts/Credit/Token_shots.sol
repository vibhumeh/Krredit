pragma solidity ^0.8.7;
import "../Token/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./credit.sol";
import "../Lending/ds-math";

contract TaxCollector is data,DSMath{
adj=10**18;
struct AccRate{
  mapping(address=> uint256) public credearning;
  mapping(address=>uint) public LastAROfClaim;
  uint lAR;
  uint256 lUpdateTime;
  uint AR;
  uint nAR;
  uint rate=5*adj/100;

}
function UpdateAR(address msg_sender){
  AccRate.nAR=AccRate.lAR+rpow((adj+AccRate.rate),AccRate.lUpdateTime-block.timestamp);
  lUpdateTime=block.timestamp;
  AccRate.lAR=nAr;
  AccRate.credearning[msg_sender]=AccRate.nAr-AccRate.LastAROfClaim[msg_sender];

}


}
