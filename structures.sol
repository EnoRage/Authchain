pragma solidity ^0.4.0;

library Structures {
    struct Author { 
        string  nameAuthor;    // Псевдоним 
        uint    timeReg;       // Время регистрации псевдонима	
        address addressAuthor; // Адрес автора
        uint    blockNumber;   // Номер блока, в котором будет добавлен автор
    }

    struct Song {
        string  nameSong;    // Название песни
        uint    time;        // Длительность песни
        uint    timeReg;     // Время регистрации песни
        bytes32 hashText;    // Хэш текста
        string  textSong;    // Текст
        address idAuthor;    // Идентификатор автора песни (его адрес)
        uint    blockNumber; // Номер блока, в котором будет добавлена песня
    }
}
