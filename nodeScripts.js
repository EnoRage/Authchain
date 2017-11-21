// Подключаем модуль с нужными функциями для подписи
var rs = require('jsrsasign');

// Создаём новую эллиптическую кривую
var ec = new rs.crypto.ECDSA({'curve': 'secp256r1'});

// Предположим, что рандомные ключи - наши
var keypair = ec.generateKeyPairHex(); // Генерируем общедоступный ключ и приватный ключ
var pubhex = keypair.ecpubhex;         // Получаем hex строку общедоступного ключа
var prvhex = keypair.ecprvhex;         // Получаем hex строку приватного ключа

var m = "my message"; // Строка сервера

// Функция, которая переводит строку в шестнадцатеричный формат
function ascii_to_hexa(str) 
{
    var arr1 = [];
    for (var n = 0, l = str.length; n < l; n ++) 
     {
        var hex = Number(str.charCodeAt(n)).toString(16);
        arr1.push(hex);
     }
    return arr1.join('');
}

var hexMessage = ascii_to_hexa(m);             // Переводим в шестнадцатеричный формат строку сервера
var sigValue = ec.signHex(hexMessage, prvhex); // Подписываем сообщение приватным ключом

// Подтверждаем подлинность подписанного сообщения при помощи общедоступного ключа
var result = ec.verifyHex(hexMessage, sigValue, prvhex); 

console.log(result); // Если кошелёк принадлежит тебе и сообщение не было перехвачено и изменено ---> true