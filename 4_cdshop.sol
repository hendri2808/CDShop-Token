// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CDShop is ERC20, Ownable {
    string private _name = "CDShop";
    string private _symbol = "CD$";
    uint8 private _decimals = 8;
    uint256 private _maxTotalSupply = 1000000000 * (10 ** uint256(_decimals));
    address private _ownerWallet = 0x474F370687070aF7d92cc6Dd1F8Fe88233E9beD2;
    string private _ownerToken = "ANR Group";
    string private _securityContact = "hrahmat@anrworkgroup.com";
    string private _website = "https://creativeds.shop/";

    constructor() ERC20(_name, _symbol) Ownable(msg.sender) {
        _mint(_ownerWallet, _maxTotalSupply);
    }

    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }

    function upgrade(address newContract) external onlyOwner {
        require(newContract != address(0), "Invalid address");
        
        uint256 balance = balanceOf(_msgSender());
        _burn(_msgSender(), balance);
        
        CDShop(newContract).mint(_msgSender(), balance);
    }
}