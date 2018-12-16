var Web3 = require('web3');
var web3 = new Web3(new Web3.providers.HttpProvider('http://bossy-panda-06220.getho.io/jsonrpc'));

var earthchat = {

getChat : function(){
        let account = web3.eth.accounts[0];
//今トラクタのアドレス
var address = '0x2994ff8feff01c7a1a2324cd22735210da1e61d8';

//abi情報
var abi = [
    {
      "constant": false,
      "inputs": [
        {
          "name": "_con",
          "type": "uint256"
        },
        {
          "name": "_userid",
          "type": "uint256"
        },
        {
          "name": "_text",
          "type": "string"
        }
      ],
      "name": "set",
      "outputs": [],
      "payable": false,
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "name": "_con",
          "type": "uint256"
        }
      ],
      "name": "get_length",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    },
    {
      "constant": true,
      "inputs": [
        {
          "name": "_con",
          "type": "uint256"
        },
        {
          "name": "_i",
          "type": "uint256"
        }
      ],
      "name": "get_talk",
      "outputs": [
        {
          "name": "",
          "type": "uint256"
        },
        {
          "name": "",
          "type": "string"
        },
        {
          "name": "",
          "type": "uint256"
        }
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    }
  ];

    var contract = web3.eth.contract(abi).at(address);
    let length = contract.get_length.call(11);
    var talks = [];
    var chats = [];
   for(j=0; j < length; j++ ){
       let talk = contract.get_talk.call(11, j);
       var chat = {
        userID: talk[0]["c"][0],
        text: talk[1],
        timeStamp: talk[2]["c"][0]
        }
        
        chats.push(chat)
   }
   return chats
   
   console.log("aaavvvvvvvvv")
    return chats
}
}
module.exports = earthchat

//userid
//chat
//timestamp
