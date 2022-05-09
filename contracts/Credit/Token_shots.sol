pragma solidity ^0.8.7;
import "../NFT/NFT.sol";
import "../Lending/ds-math/math.sol";

contract TaxCollector is data,DSMath{
//

function wpow(uint x, uint n) public returns (uint z) {
   x=x*WAD;
   z = n % 2 != 0 ? x : WAD;

   for (n /= 2; n != 0; n /= 2) {
       x = wmul(x, x);

       if (n % 2 != 0) {
           z = wmul(z, x);
       }
   }
}

//
uint adj=10**18;
struct AccRate{
  mapping(address=> uint256)  credearning;
  mapping(address=>uint)  LastAROfClaim;
  uint lAR;
  uint256 lUpdateTime;
  uint AR;
  uint nAR;
  uint rate; //need to initiallise rate.

}
function UpdateAR(address msg_sender)public {
  AccRate.nAR=add(AccRate.lAR,wpow((adj+AccRate.rate),AccRate.lUpdateTime-block.timestamp));
  AccRate.lUpdateTime=block.timestamp;
  AccRate.lAR=AccRate.nAR;
  AccRate.credearning[msg_sender]=sub(AccRate.nAr,AccRate.LastAROfClaim[msg_sender]);
  AccRate.LastAROfClaim[msg_sender]=AccRate.nAr;

}// needs access specifiers.
function UpdateAR(address msg_sender,address to) public returns(bool){
  AccRate.nAR=add(AccRate.lAR,wpow((add(adj,AccRate.rate)),sub(block.timestamp,AccRate.lUpdateTime)));
  AccRate.lUpdateTime=block.timestamp;
  AccRate.lAR=AccRate.nAr;
  AccRate.credearning[msg_sender]=sub(AccRate.nAR,AccRate.LastAROfClaim[msg_sender]);
  AccRate.credearning[to]=sub(AccRate.nAR,AccRate.LastAROfClaim[to]);
  AccRate.LastAROfClaim[msg_sender]=AccRate.nAr;
  AccRate.LastAROfClaim[to]=AccRate.nAr;
  return true;
}


}
