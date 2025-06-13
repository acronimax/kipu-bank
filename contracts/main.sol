// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract KipuBank {
    uint8 constant BANK_CAP = 10;
    uint16 immutable withdrawals;
    address public owner;

    constructor(uint16 _withdrawals) {
        withdrawals = _withdrawals;
        owner = msg.sender;
    }

    // MODIFIERS
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can use this contract");
        _;
    }

    modifier validAmount() {
        require(msg.value > 0, "The ammount must be more than 0");
        _;
    }

    event ReceivedETH(address indexed from, uint256 amount, string method);
    event SendedETH(address indexed from, uint256 amount, string method);

    function deposit () external payable validAmount {
        emit SendedETH(msg.sender, msg.value, "deposit()");
    }
}