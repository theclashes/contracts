// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./TimedCrowdSale.sol";
import "../utils/Whitelist.sol";
import "./interfaces/IERC721Mintable.sol";

contract CrowdSale is Whitelist, TimedCrowdSale, Ownable {
  // The token being sold
  IERC721Mintable private _token;

  constructor(
    IERC721Mintable token, // The Clashes Token
    uint256 openingTime, // opening time in unix epoch seconds
    uint256 closingTime // closing time in unix epoch seconds
  ) TimedCrowdSale(openingTime, closingTime) {
    _token = token;
  }

  function getToken() public view returns (IERC721) {
    return _token;
  }

  function buyTokens() public payable {
    _token.safeMint(msg.sender, "");
  }

  function withdraw() external onlyOwner {
    address payable _owner = payable(msg.sender);
    uint256 balance = address(this).balance;
    _owner.transfer(balance);
  }

  function getBalance() public view onlyOwner returns (uint256) {
    return address(this).balance;
  }
}
