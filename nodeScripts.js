// var Web3 = require('web3');
// var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545", 0, BasicAuthUsername, BasicAuthPassword));

var rs = require('jsrsasign');
var rsu = require('jsrsasign-util');

var prvKey = rs.KEYUTIL.getKey(НУЖЕН PEM ФАЙЛ);
var sig = new a.Signature({alg: 'SHA1withRSA'});
sig.init(prvKey);
sig.updateString('aaa');
var sigVal = sig.sign();

//Остановился на том, что мне понадобился PEM файл, который создаётся с помощью OpenSSl))))