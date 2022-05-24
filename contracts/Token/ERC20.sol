// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "../Credit/Token_shots.sol";


contract Zeno is ERC20, ERC20Burnable, AccessControl,TaxCollector{
using SafeMath for uint256;
//




//

//
  //
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor() ERC20("Zeno", "Zn") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE,msg.sender);
    }

     mapping(address => uint) c_sum;
     mapping(address => uint) timestamp;
     uint256 k=30;
     function giveRole(address loaner) public onlyRole(DEFAULT_ADMIN_ROLE) {
         _grantRole(MINTER_ROLE, loaner);
     }
     function GetSum(address account) public view returns(uint256)
     {
       return c_sum[account];
     }
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
      UpdateAR(to);
       c_sum[to]=add(c_sum[to],(wsqrt(mul(AccRate.credearning[to],wsqrt(balanceOf(to)))).div(k)));

        _mint(to, amount);

    }

    function burn(uint amount) public override {
  UpdateAR(msg.sender);
    c_sum[msg.sender]+=wsqrt(mul(AccRate.credearning[msg.sender],wsqrt(balanceOf(msg.sender)))).div(k);

    _burn(msg.sender,amount);

    }
    function burnFrom(address account, uint256 amount) override public virtual {
      UpdateAR(account);
       c_sum[account]+=wsqrt(mul(AccRate.credearning[account],wsqrt(balanceOf(account)))).div(k);

        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);

    }
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
    UpdateAR(msg.sender,to);
        c_sum[to]+=wsqrt(mul(AccRate.credearning[to],wsqrt(balanceOf(to)))).div(k);
        c_sum[msg.sender]+=wsqrt(mul(AccRate.credearning[msg.sender],wsqrt(balanceOf(to)))).div(k);
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
        c_sum[to]+=wsqrt(mul(AccRate.credearning[to],wsqrt(balanceOf(to)))).div(k);
        c_sum[from]+=wsqrt(mul(AccRate.credearning[from],wsqrt(balanceOf(to)))).div(k);

            address spender = _msgSender();
            _spendAllowance(from, spender, amount);
            _transfer(from, to, amount);
        return true;
    }
    //
    function redeem() public returns(bool){
      require(Primary[msg.sender]!=0);
      require(block.timestamp-timestamp[msg.sender]>1260);
      cred[Primary[msg.sender]].creditsc_c=add(cred[Primary[msg.sender]].creditsc_c,c_sum[msg.sender]);
      c_sum[msg.sender]=0;
      timestamp[msg.sender]=block.timestamp;
      return true;
    }
}
