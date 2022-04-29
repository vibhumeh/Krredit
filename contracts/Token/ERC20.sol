// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract Zeno is ERC20, ERC20Burnable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    constructor(address loaner) ERC20("Zeno", "Zn") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, loaner);
    }

     mapping(address => uint) sum;
     mapping(address => uint) time;
     function sum(address account) public returns(uint256)
     {
       return sum[address];
     }
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
       sum[to]=balanceOf(to)*(block.timestamp-time[to]);
       time[to]=block.timestamp;
        _mint(to, amount);

    }

    function burn(uint amount) public override {
    sum[msg.sender]=balanceOf(msg.sender)*(block.timestamp-time[msg.sender]);
     time[msg.sender]=block.timestamp;
    _burn(msg.sender,amount);

    }
    function burnFrom(address account, uint256 amount) override public virtual {
       sum[account]=balanceOf(account)*(block.timestamp-time[account]);
        time[account]=block.timestamp;
        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);
    }
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        sum[to]=balanceOf(to)*(block.timestamp-time[to]);
        sum[msg.sender]=balanceOf(msg.sender)*(block.timestamp-time[msg.sender]);
         time[msg.sender]=block.timestamp;
          time[to]=block.timestamp;
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override returns (bool) {
        sum[to]=balanceOf(to)*(block.timestamp-time[to]);
        sum[from]=balanceOf(from)*(block.timestamp-time[from]);
         time[to]=block.timestamp;
         time[from]=block.timestamp;
            address spender = _msgSender();
            _spendAllowance(from, spender, amount);
            _transfer(from, to, amount);
        return true;
    }
}
