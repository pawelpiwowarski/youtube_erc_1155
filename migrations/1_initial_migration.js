const nft = artifacts.require("nft_contract");

module.exports = function (deployer) {
  deployer.deploy(nft, "string");
};
