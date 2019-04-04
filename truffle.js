var HDWalletProvider = require('truffle-hdwallet-provider');

var mnemonic = 'conduct shop dumb crash pretty movie gesture ski calm beach injury mixture';
// 0x0782140de231a91c2cef8c830107d995043cb2cc

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*" // Match any network id
    },
    rinkeby: {
      provider: function() { 
        return new HDWalletProvider(mnemonic, 'https://rinkeby.infura.io/v3/03d89c950ad34f32a21cb687dda35c60') 
      },
      network_id: 4,
      gas: 4500000,
      gasPrice: 10000000000,
    }
  }
};