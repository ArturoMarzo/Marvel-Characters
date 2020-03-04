import UIKit

class CharacterDTOProvider {
    static func characterDTOWith(pageSize: Int, totalResults: Int) -> Characters {
        var charactersEntity = [CharacterEntity]()
        for index in 0...pageSize {
            let characterEntity = CharacterEntity(id: UInt(index),
                                            name: "name",
                                            description: "description",
                                            thumbnail: CharacterImageEntity(path: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                                                                         extensionFile: "jpg"))
            charactersEntity.append(characterEntity)
        }
        
        let charactersDTO = Characters(charactersEntity: charactersEntity, total: totalResults)
        
        return charactersDTO
    }
}
