pragma solidity ^0.4.0;

library Structures {
    struct Author { 
        string  nameAuthor;    // Псевдоним 
        string  email;         // E-mail автора
        uint    timeReg;       // Время регистрации псевдонима	
        address addressAuthor; // Адрес автора
        uint    blockNumber;   // Номер блока, в котором будет добавлен автор
    }

    struct Image {
        string  nameImage;   // Название песни
        string  size;        // Размер изображения
        uint    timeReg;     // Время регистрации изображения
        bytes32 hashImage;   // Хэш изображения
        address idAuthor;    // Идентификатор автора изображения (его адрес)
        uint    blockNumber; // Номер блока, в котором будет добавлена песня
    }
}
