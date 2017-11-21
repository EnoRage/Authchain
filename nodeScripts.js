var rs = require('jsrsasign');
var cr = require('crypto-js');
var rsu = require('jsrsasign-util');

// Создаём новую элептическую кривую
var ec = new rs.crypto.ECDSA({'curve': 'secp256r1'});

var keypair = ec.generateKeyPairHex(); // Генерируем общедоступный ключ и приватный ключ
var pubhex = keypair.ecpubhex;         // Получаем hex строку общедоступного ключа
var prvhex = keypair.ecprvhex;         // Получаем hex строку приватного ключа

var m = "my message"; // Наше сообщение

// Функция, которая переводит строку в шестнадцатеричный формат
function ascii_to_hexa(str) {
  var arr1 = [];
  for (var n = 0, l = str.length; n < l; n ++) 
   {
      var hex = Number(str.charCodeAt(n)).toString(16);
      arr1.push(hex);
   }
  return arr1.join('');
 }


var hexMessage= ascii_to_hexa(m);              // Переводим в шестнадцатеричный формат наше сообщение
var sigValue = ec.signHex(hexMessage, prvhex); // Подписываем сообщение приватным ключом
  
var result = ec.verifyHex(hexMessage, sigValue, pubhex); // Подтверждаем подлинность подписанного сообщения при помощи 

console.log(result);