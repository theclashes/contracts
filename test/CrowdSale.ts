import { expect } from "chai";
import { ethers } from "hardhat";

describe("Crowdsale", () => {
  it("should view the contract balance", async () => {
    // const [owner] = await ethers.getSigners();

    const TCE = await ethers.getContractFactory("TheClashesCharacter");
    const tce = await TCE.deploy();
    await tce.deployed();

    const date = new Date();
    const futureDate = new Date().setDate(date.getDate() + 2);

    const CrowdSale = await ethers.getContractFactory("CrowdSale");
    const crowdSale = await CrowdSale.deploy(
      tce.address,
      date.getTime(),
      futureDate
    );
    await crowdSale.deployed();

    const MINTER_ROLE = await tce.MINTER_ROLE.call({});

    await tce.grantRole(MINTER_ROLE, crowdSale.address);

    const options = {
      value: ethers.utils.parseEther("1.0"),
    };

    await crowdSale.buyTokens(options);

    const balance = await crowdSale.getBalance();

    const totalSupply = await tce.totalSupply();

    const COMMOM_RARITY = await tce.COMMOM_RARITY.call({});
    const RARE_RARITY = await tce.RARE_RARITY.call({});

    const rarity = await tce.getRarityByTokenId(0);

    if (rarity === COMMOM_RARITY) console.log("Gerou um comum");
    if (rarity === RARE_RARITY) console.log("Gerou um raro");

    expect(totalSupply).to.equal("1");
    expect(balance).to.equal("1000000000000000000");
  });
});
