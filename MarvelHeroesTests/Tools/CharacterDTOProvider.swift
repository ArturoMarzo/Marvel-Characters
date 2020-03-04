import UIKit

class CharacterDTOProvider {
    static func characterDTOWith(pageSize: Int, totalResults: Int) -> CharactersDTO {
        var charactersDAO = [CharacterDAO]()
        for index in 0...pageSize {
            let characterDAO = CharacterDAO(id: UInt(index),
                                            name: "name",
                                            description: "description",
                                            thumbnail: CharacterImageDAO(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                                                                         extensionFile: "jpg"))
            charactersDAO.append(characterDAO)
        }
        
        let charactersDTO = CharactersDTO(charactersDAO: charactersDAO, total: totalResults)
        
        return charactersDTO
    }
}
