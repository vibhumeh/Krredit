pragma solidity ^0.8.7;
import "../NFT/NFT.sol";
import "../Lending/ds-math/math.sol";

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
function UpdateAR(address msg_sender)public {
  AccRate.nAR=AccRate.lAR+rpow((adj+AccRate.rate),AccRate.lUpdateTime-block.timestamp);
  lUpdateTime=block.timestamp;
  AccRate.lAR=nAr;
  AccRate.credearning[msg_sender]=AccRate.nAr-AccRate.LastAROfClaim[msg_sender];

}// needs access specifiers.
function UpdateAR(address msg_sender,address to) public returns(bool){
  AccRate.nAR=AccRate.lAR+rpow((adj+AccRate.rate),block.timestamp-AccRate.lUpdateTime);
  AccRate.lUpdateTime=block.timestamp;
  AccRate.lAR=AccRate.nAr;
  AccRate.credearning[msg_sender]=AccRate.nAR-AccRate.LastAROfClaim[msg_sender];
  AccRate.credearning[to]=AccRate.nAR-AccRate.LastAROfClaim[to];
  return true;
}


}
