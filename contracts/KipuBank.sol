// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

error DepositLimitReached();
error ExceedsVaultBalance();
error ExceedsWithdrawLimit();
error ZeroAmountNotAllowed();

contract KipuBank {
    uint256 public immutable withdrawLimit;
    uint256 public immutable bankCap;
    uint256 public totalDeposits;
    uint256 public totalWithdrawals;
    uint256 private bankBalance;
    address public owner;

    mapping(address => uint256) private userVault;

    constructor(uint256 _withdrawLimit, uint256 _bankCap) {
        withdrawLimit = _withdrawLimit;
        bankCap = _bankCap;
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

    function deposit() external payable validAmount {
        if (msg.value == 0) revert ZeroAmountNotAllowed();
        if (bankBalance + msg.value > bankCap) revert DepositLimitReached();

        userVault[msg.sender] += msg.value;
        bankBalance += msg.value;
        totalDeposits++;

        emit SendedETH(msg.sender, msg.value, "deposit()");
    }

    function withdrawal(uint256 amount) external {
        if (amount == 0) revert ZeroAmountNotAllowed();
        if (amount > withdrawLimit) revert ExceedsWithdrawLimit();
        if (amount > userVault[msg.sender]) revert ExceedsVaultBalance();

        userVault[msg.sender] -= amount;
        bankBalance -= amount;
        totalWithdrawals++;
        _sendEther(msg.sender, amount);

        emit ReceivedETH(msg.sender, amount, "withdrawal()");
    }

    function checkVault(address user) external view returns (uint256) {
        return userVault[user];
    }

    function _sendEther(address to, uint256 amount) private {
        (bool sent, ) = to.call{value: amount}("");
        require(sent, "Transfer failed");
    }

    receive() external payable {
        revert("Use deposit()");
    }

    fallback() external payable {
        revert("Use deposit()");
    }
}
