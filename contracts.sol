pragma solidity ^0.4.0;
import "./structures.sol";

contract ImageAuthority {
    mapping(address => Structures.Author) public autors; // Этот массив хранит в блокчейне всех авторов
    mapping(uint256 => Structures.Image)  public images; // Этот массив хранит в блокчейне все песни

    // Добавление автора
    function addAuthor(string nameAuthor) public {
        autors[msg.sender] = Structures.Author(nameAuthor, block.timestamp, msg.sender, block.number); // Добавляем автора
    }

    // ID предыдущей песни
    uint256 lastImageId = 0; // Хранится блокчейне
   
    //Добавляем песню
    function addImage(string nameImage, uint8 time, bytes32 hashImage) public { 
        for (uint256 i = 0; i <= lastImageId; i++) {                                                                                                         // создаем цикл в котором перебираем все id песен 
            require(hashImage != images[lastImageId].hashImage);                                                                                                // если hash нашей новой песни != hash какой-то песни, то функция останавливается
        }
        // if (autors[msg.sender].addressAuthor == msg.sender) {
            
        // }                                                                                                                                                  // Увеличиваем счетчик на 1    
        images[lastImageId] = Structures.Image(nameImage, time, block.timestamp, keccak256(hashImage), msg.sender, block.number); // Добавляем песню
        lastImageId++;  
    }  
}

//Контракт для получения данных об авторе
contract GetAuthor is ImageAuthority {
   function getAuthor(address author) constant public returns(Structures.Author) { return autors[author]; }
} 

//Контракт для получения данных о песне
contract GetSong is ImageAuthority {
   function getImage(uint imageId) constant public returns(Structures.Image) { return images[imageId]; }
} 

//Контракт для изменения автора песни
contract ChangeSongAuthority is ImageAuthority {
    function setNewAuthority(string nameImage, address newIdAuthor) public {     // Вводим название песни и адрес нового автора
        for (uint256 i = 0; i <= lastImageId; i++) {                             // Перебираем весь массив с песнями
            if (keccak256(nameImage) == keccak256(images[lastImageId].nameImage)) { // Если песня нашлась по названию, то
                require(images[lastImageId].idAuthor == msg.sender);              // Делаем проверку (изменить может только автор песни)
                images[lastImageId].idAuthor = newIdAuthor;                       // Присваеваем песне новое авторство
            }
        }
    }
}