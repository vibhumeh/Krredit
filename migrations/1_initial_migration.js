const Migrations = artifacts.require("Migrations");
const Lending = artifacts.require("Loaning");
const NFT =artifacts.require("Credit");
const Token = artifacts.require("Zeno");
module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(NFT);
  deployer.deploy(Token);
  deployer.deploy(Lending);
};
