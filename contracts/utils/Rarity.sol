// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./Random.sol";

contract Rarity is Random {
  bytes32 public constant COMMOM_RARITY = keccak256("COMMOM_RARITY");
  bytes32 public constant RARE_RARITY = keccak256("RARE_RARITY");
  bytes32 public constant SUPER_RARE_RARITY = keccak256("SUPER_RARE_RARITY");
  bytes32 public constant LEGENDARY_RARITY = keccak256("LEGENDARY_RARITY");

  mapping(uint256 => bytes32) private _tokenIdToRarity;

  function generateRandomRarity(uint256 tokenId) internal returns (bytes32) {
    uint256 randomNumber = getRandom();

    bytes32 generatedRarity = COMMOM_RARITY;

    if (randomNumber > 5) {
      generatedRarity = RARE_RARITY;
    }

    _tokenIdToRarity[tokenId] = generatedRarity;

    return generatedRarity;
  }

  function getRarityByTokenId(uint256 tokenId) public view returns (bytes32) {
    return _tokenIdToRarity[tokenId];
  }
}
