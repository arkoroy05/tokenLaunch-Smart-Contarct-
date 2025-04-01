// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Coin is ERC20 {
    constructor (address owner,string memory name, string memory symbol,uint amount) ERC20(name, symbol) {
       _mint(owner, amount);
    }
}


contract LaunchPad{
    IERC20 public token;
    Coin coin;
    address[] public Coins; 
    mapping(address=>address[]) owners;
    event Deploy(address indexed owner, address indexed token,string name, string symbol);

    function deployCoin(string memory name, string memory symbol,uint amount) external returns(address){
        coin = new Coin(msg.sender,name,symbol,amount);
        Coins.push(address(coin));
        owners[msg.sender].push(address(coin));
        emit Deploy(msg.sender, address(coin),name, symbol);
        return address(coin);
    }

    function getDeployedTokens() external view returns (address[] memory) {
        return Coins;
    }

    function getUserTokens() external view returns (address[] memory) {
        return owners[msg.sender];
    }

    function totalSupply(address _token) external view returns (uint256) {
        return IERC20(_token).totalSupply();
    }
}