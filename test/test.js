const nft_contract = artifacts.require("nft_contract");




contract("erc 1155 test", (accounts) => {
  it("deploys", async () => {

    const metaCoinInstance = await nft_contract.deployed();
    assert.ok(metaCoinInstance.address)
    assert.equal(await metaCoinInstance.owner.call(), accounts[0])
  }); 
});