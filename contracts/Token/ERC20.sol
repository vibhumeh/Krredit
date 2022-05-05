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
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor(address loaner) ERC20("Zeno", "Zn") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, loaner);
    }

     mapping(address => uint) sum;
     mapping(address => uint) timestamp;
     function GetSum(address account) public returns(uint256)
     {
       return sum[address];
     }
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
      UpdateAR(to);
       sum[to]+=AccRate.credearning[msg.sender]*sqrt(balanceOf[to]);

        _mint(to, amount);

    }

    function burn(uint amount) public override {
  UpdateAR(msg.sender);
    sum[msg.sender]=balanceOf(msg.sender)*(block.timestamp-time[msg.sender]);

    _burn(msg.sender,amount);

    }
    function burnFrom(address account, uint256 amount) override public virtual {
      UpdateAR(account);
       sum[account]=balanceOf(account)*(block.timestamp-time[account]);

        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);

    }
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
    UpdateAR(msg.sender,to);
        sum[to]=balanceOf(to)*(block.timestamp-time[to]);
        sum[msg.sender]=balanceOf(msg.sender)*(block.timestamp-time[msg.sender]);
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
        sum[to]=balanceOf(to)*(block.timestamp-time[to]);
        sum[from]=balanceOf(from)*(block.timestamp-time[from]);

            address spender = _msgSender();
            _spendAllowance(from, spender, amount);
            _transfer(from, to, amount);
        return true;
    }
    //
    function redeem() public returns(bool){
      require(Primary[msg.sender]!=0);
      require(block.timestamp-timstamp[msg.sender]>1260);
      cred[Primary[msg.sender]].creditsc_c+=sum;
      sum=0;
      timstamp[msg.sender]=block.timstamp;
    }
}
