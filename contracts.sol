pragma solidity ^0.4.0;
import "./structures.sol";

contract ImageAuthority {
    mapping(address => Structures.Author) public autors; // Этот массив хранит в блокчейне всех авторов
    mapping(uint256 => Structures.Image)  public images; // Этот массив хранит в блокчейне все песни

    // Добавление автора
    function addAuthor(string nameAuthor, string email) public {
        autors[msg.sender] = Structures.Author(nameAuthor, email, block.timestamp, msg.sender, block.number); // Добавляем автора
    }

    // ID предыдущего изображения
    uint256 lastImageId = 0; // Хранится блокчейне
   
    //Добавляем изображение
    function addImage(string nameImage, string size) public returns(string) { 
        bytes32 hashImage = "9999";
        for (uint256 i = 0; i <= lastImageId; i++) {                                                                              // создаем цикл в котором перебираем все id песен 
            if (keccak256(hashImage) == keccak256(images[i].hashImage)) {                                                         // Проверяем на наличие такой картинки   
                return "Такая картинка уже есть.";
            }                                                                             
        }
        require (autors[msg.sender].addressAuthor == msg.sender);                                                                 // Создан ли автор?
        images[lastImageId] = Structures.Image(nameImage, size, block.timestamp, keccak256(hashImage), msg.sender, block.number); // Добавляем песню
        lastImageId++;  
    }  
}

//Контракт для изменения автора песни
contract ChangeSongAuthority is ImageAuthority {
    function setNewAuthority(string nameImage, address newIdAuthor) public returns(string) {        // Вводим название песни и адрес нового автора
        for (uint256 i = 0; i <= lastImageId; i++) {                                                // Перебираем весь массив с песнями
            if (keccak256(nameImage) == keccak256(images[i].nameImage)) {                           // Если песня нашлась по названию, то
                if (images[i].idAuthor != msg.sender) {                                             // Делаем проверку (изменить может только автор песни)
                    return "Вы не создали автора.";
                }
                images[i].idAuthor = newIdAuthor;                                                   // Присваеваем песне новое авторство
            }
        }
    }
}