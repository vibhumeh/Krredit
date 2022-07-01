pragma solidity ^0.8.7;
import "../NFT/NFT.sol";
import "../Lending/ds-math/math.sol";
import "../Lending/ILoaning.sol";
contract TaxCollector is DSMath{
//

//
uint adj=10**18;
struct _AccRate{
  mapping(address=> uint256)  credearning;
  mapping(address=>uint)  LastAROfClaim;
  uint lAR;
  uint256 lUpdateTime;
  uint AR;
  uint nAR;
  uint rate; //need to initiallise rate.

}
_AccRate AccRate;
constructor() {
  AccRate.rate=1;
  AccRate.lUpdateTime=block.timestamp;
}
function UpdateAR(address msg_sender)public {
 AccRate.nAR=add(AccRate.lAR,wpow((adj+AccRate.rate),sub(block.timestamp,AccRate.lUpdateTime)));
  AccRate.lUpdateTime=block.timestamp;
  AccRate.lAR=AccRate.nAR;
  AccRate.credearning[msg_sender]=sub(AccRate.nAR,AccRate.LastAROfClaim[msg_sender]);
  AccRate.LastAROfClaim[msg_sender]=AccRate.nAR;

}// needs access specifiers.
function UpdateAR(address msg_sender,address to) public returns(bool){
 AccRate.nAR=add(AccRate.lAR,wpow((add(adj,AccRate.rate)),sub(block.timestamp,AccRate.lUpdateTime)));
  AccRate.lUpdateTime=block.timestamp;
  AccRate.lAR=AccRate.nAR;
  AccRate.credearning[msg_sender]=sub(AccRate.nAR,AccRate.LastAROfClaim[msg_sender]);
  AccRate.credearning[to]=sub(AccRate.nAR,AccRate.LastAROfClaim[to]);
  AccRate.LastAROfClaim[msg_sender]=AccRate.nAR;
  AccRate.LastAROfClaim[to]=AccRate.nAR;
  return true;
}


}
