var Web3 = require('web3');
var web3 = new Web3();
web3.setProvider(new web3.providers.HttpProvider('http://localhost:8545'));
var _account = web3.personal.newAccount("test");
console.log(_account)

