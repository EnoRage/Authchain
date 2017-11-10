pragma solidity ^0.4.0;
import "./structures.sol";

contract SongAuthority {
    mapping(address => Structures.Author) public autors; // Этот массив хранит в блокчейне всех авторов
    mapping(uint256 => Structures.Song)   public songs;  // Этот массив хранит в блокчейне все песни

    // Добавление автора
    function addAuthor(string nameAuthor) internal {
        autors[msg.sender] = Structures.Author(nameAuthor, block.timestamp, msg.sender, block.number); // Добавляем автора
    }

    // ID предыдущей песни
    int256 lastSongId = -1; // Хранится блокчейне
   
    //Добавляем песню
    function addSong(string nameSong, uint8 time, bytes32 hashSong, bytes32 hashText, string textSong) internal { 
        lastSongId++;  
        for(int256 i = 0; i < lastSongId-1; i++)  {                                                                                                       // создаем цикл в котором перебираем все id песен 
            require(hashSong != songs[uint256(lastSongId)].hashSong);                                                                                     // если hash нашей новой песни != hash какой-то песни, то функция останавливается
        }                                                                                                                                                 // Увеличиваем счетчик на 1    
        songs[uint256(lastSongId)] = Structures.Song(nameSong, time, block.timestamp, keccak256(hashSong), keccak256(hashText), textSong, msg.sender, block.number); // Добавляем песню
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

//Теперь все на гите 
