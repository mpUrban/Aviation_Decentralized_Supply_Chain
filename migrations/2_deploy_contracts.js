// migrating the appropriate contracts
var ShopRole = artifacts.require("./ShopRole.sol");
var StoreRole = artifacts.require("./StoreRole.sol");
var BuyerRole = artifacts.require("./BuyerRole.sol");
var SupplyChain = artifacts.require("./SupplyChain.sol");

module.exports = function(deployer) {
  deployer.deploy(ShopRole);
  deployer.deploy(StoreRole);
  deployer.deploy(BuyerRole);
  deployer.deploy(SupplyChain);
};
