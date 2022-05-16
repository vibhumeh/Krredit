const Token = artifacts.require("Zeno");
const Lending = artifacts.require("Loaning")
module.exports = function (deployer) {
const lent=Lending.address;
    deployer.deploy(Token());

};
