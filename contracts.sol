pragma solidity ^0.4.0;
import "./structures.sol";

// contract Ownable {
//      address owner;
 
//     modifier onlyOwner() {
//         require(msg.sender == owner);
//         _;
//     }
    
 
//     function transferOwnership(address newOwner) onlyOwner {
// 	    owner = newOwner;
//     }
    
// }
contract SongAuthority {
    mapping(address => Structures.Author) public autors; // Этот массив хранит в блокчейне всех авторов
    mapping(uint256 => Structures.Song)   public songs;  // Этот массив хранит в блокчейне все песни

    // Добавление автора
    function addAuthor(string nameAuthor) internal {
        autors[msg.sender] = Structures.Author(nameAuthor, block.timestamp, msg.sender, block.number); // Добавляем автора
    }

    // ID предыдущей песни
    uint256 lastSongId = 0; // Хранится блокчейне
   
    //Добавляем песню
    function addSong(string nameSong, uint8 time, bytes32 hashSong, bytes32 hashText, string textSong) internal { 
        for (uint256 i = 0; i <= lastSongId; i++) {                                                                                                         // создаем цикл в котором перебираем все id песен 
            require(hashSong != songs[lastSongId].hashSong);                                                                                                // если hash нашей новой песни != hash какой-то песни, то функция останавливается
        }                                                                                                                                                   // Увеличиваем счетчик на 1    
        songs[lastSongId] = Structures.Song(nameSong, time, block.timestamp, keccak256(hashSong), keccak256(hashText), textSong, msg.sender, block.number); // Добавляем песню
        lastSongId++;  
    }  
}

//Контракт для получения данных об авторе
contract GetAuthor is SongAuthority {
   function getAuthor(address author) constant public returns(Structures.Author) { return autors[author]; }
} 

//Контракт для получения данных о песне
contract GetSong is SongAuthority {
   function getSong(uint songId) constant public returns(Structures.Song) { return songs[songId]; }
} 

//Контракт для изменения автора песни
contract ChangeSongAuthority is SongAuthority {
    function setNewAuthority(string nameSong, address newIdAuthor) public {     // Вводим название песни и адрес нового автора
        for (uint256 i = 0; i <= lastSongId; i++) {                             // Перебираем весь массив с песнями
            if (keccak256(nameSong) == keccak256(songs[lastSongId].nameSong)) { // Если песня нашлась по названию, то
                require(songs[lastSongId].idAuthor == msg.sender);              // Делаем проверку (изменить может только автор песни)
                songs[lastSongId].idAuthor = newIdAuthor;                       // Присваеваем песне новое авторство
            }
        }
    }
}