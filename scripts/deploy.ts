/* eslint-disable no-process-exit */
import { ethers } from "hardhat";

async function main() {
  const TheClashesCharacter = await ethers.getContractFactory(
    "TheClashesCharacter"
  );

  const tchar = await TheClashesCharacter.deploy();

  console.log("TheClashesCharacter deployed to:", tchar.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
