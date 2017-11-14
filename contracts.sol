pragma solidity ^0.4.0;
import "./structures.sol";





contract ImageAuthority {
    mapping(uint256 => Structures.Author) public autors; // Этот массив хранит в блокчейне всех авторов
    mapping(uint256 => Structures.Image)  public images; // Этот массив хранит в блокчейне все песни

    // ID предыдущего автора
    uint256 authorId = 0; // Хранится блокчейне

    // Добавление автора
    function addAuthor(string nameAuthor, string email) public {
        //Проверяем на авторство псевдоним
        for (uint256 i = 0; i <= authorId; i++) {
            require(keccak256(autors[i].nameAuthor) != keccak256(nameAuthor));
        }

        autors[authorId] = Structures.Author(nameAuthor, email, block.timestamp, msg.sender, block.number); // Добавляем автора
        authorId++;
    }

    // ID предыдущего изображения
    uint256 imageId = 0; // Хранится блокчейне
    bytes32 hashImage = "9999";

    //Добавляем изображение
    function addImage(string nameImage, string size) public returns(bytes32) { 
        
        for (uint256 i = 0; i <= imageId; i++) {
            require (images[i].hashImage != keccak256(hashImage)); // Проверка на существование изображения 
            require (autors[i].addressAuthor == msg.sender);       // Проверяем на существование автора
        }
                                                           
        images[imageId] = Structures.Image(nameImage, size, block.timestamp, keccak256(hashImage), msg.sender, block.number); // Добавляем песню
        imageId++;  
    }  
}

//Контракт для изменения автора изображения
contract ChangeSongAuthority is ImageAuthority {
    function setNewAuthority(string nameImage, address newIdAuthor) public returns(string) {  // Вводим название песни и адрес нового автора
        for (uint256 i = 0; i <= imageId; i++) {                                              // Перебираем весь массив с песнями
            if (keccak256(nameImage) == keccak256(images[i].nameImage)) {                     // Если изображение нашлось по названию, то
                require(images[i].idAuthor == msg.sender);                                    // Не даём изменить авторство, если ты не владелец фотки
                images[i].idAuthor = newIdAuthor;                                             // Если владелец, то изменяем авторство
                return "Автор изменён";                                                       
            }
        }
    }
}