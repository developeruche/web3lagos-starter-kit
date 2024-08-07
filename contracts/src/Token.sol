// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";





contract TestToken is ERC20, ERC20Permit, ERC20Pausable, Ownable {
    mapping(address => bool) private blacklist;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply,
        address _recipent
    ) ERC20(_name, _symbol) ERC20Permit(_name) {
        _mint(_recipent, _initialSupply);
    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        _mint(_to, _amount);
    }

    function burn(address _from, uint256 _amount) public onlyOwner {
        _burn(_from, _amount);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function blacklistAddress(address _address) public onlyOwner {
        blacklist[_address] = true;
    }

    function unBlacklistAddress(address _address) public onlyOwner {
        blacklist[_address] = false;
    }

    function isBlacklisted(address _address) public view returns (bool) {
        return blacklist[_address];
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Pausable) {
        require(!blacklist[from], "TST: sender is blacklisted");
        require(!blacklist[to], "TST: recipient is blacklisted");

        super._beforeTokenTransfer(from, to, amount);
    }
}
