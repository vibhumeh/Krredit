// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "../Credit/Token_shots.sol";


contract Zeno is ERC20, ERC20Burnable, AccessControl,TaxCollector{
//


function sqrt(uint x) public returns (uint y) {
    uint z = (x + 1) / 2;
    y = x;
    while (z < y) {
        y = z;
        z = (x / z + z) / 2;
    }
}
//
function wsqrt(uint x) public returns (uint y) {
    uint y;
    uint k=x;
    x*=WAD;
    uint z = (x + 1)/2;
    y = x;
    while (z < y) {
        y = z;
        z = (wdiv(x,z) + z) / 2;
    }
}
//
  //
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor(address loaner) ERC20("Zeno", "Zn") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, loaner);
    }

     mapping(address => uint) c_sum;
     uint236 k=30;
     function GetSum(address account) public returns(uint256)
     {
       return sum[address];
     }
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
      UpdateAR(to);
       c_sum[to]+=div(wsqrt(mul(AccRate.credearning[msg.sender],wsqrt(balanceOf[to]))),k);

        _mint(to, amount);

    }

    function burn(uint amount) public override {
  UpdateAR(msg.sender);
    c_sum[msg.sender]+=div(wsqrt(mul(AccRate.credearning[msg.sender],wsqrt(balanceOf[to]))),k);

    _burn(msg.sender,amount);

    }
    function burnFrom(address account, uint256 amount) override public virtual {
      UpdateAR(account);
       c_sum[to]+=div(wsqrt(mul(AccRate.credearning[account],wsqrt(balanceOf[to]))),k);

        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);

    }
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
    UpdateAR(msg.sender,to);
        c_sum[to]+=div(wsqrt(mul(AccRate.credearning[to],sqrt(balanceOf[to]))),k);
        c_sum[msg.sender]+=div(wsqrt(mul(AccRate.credearning[msg.sender],wsqrt(balanceOf[to]))),k);
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override returns (bool) {
      UpdateAR(from,to);
        c_sum[to]+=div(wsqrt(mul(AccRate.credearning[to],wsqrt(balanceOf[to]))),k);
        c_sum[from]+=div(wsqrt(mul(AccRate.credearning[from],wsqrt(balanceOf[to]))),k);

            address spender = _msgSender();
            _spendAllowance(from, spender, amount);
            _transfer(from, to, amount);
        return true;
    }
    //
    function redeem() public returns(bool){
      require(Primary[msg.sender]!=0);
      require(block.timestamp-timstamp[msg.sender]>1260);
      cred[Primary[msg.sender]].creditsc_c+=c_sum;
      sum=0;
      timstamp[msg.sender]=block.timstamp;
    }
}
