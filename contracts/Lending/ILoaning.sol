// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;


interface ILoaning{
    function takeloan(uint) external;
    function returnloan(uint) external returns(bool);
    function increment(address,uint256) external;
    function creditsc_c(address) external returns(uint);
    function creditsc_uc(address) external returns(uint);
    function Pending(address) external returns(bool);
    function cooldown(address) external returns(uint);
    function Prime(address) external view returns(uint);
    function Prime(address,uint) external;
    function Reset_credit(uint ID) external;

}
