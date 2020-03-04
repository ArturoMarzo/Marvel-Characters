struct CharactersListResponseEntity: Codable {
    let data: CharactersListaDataEntity?
}

struct CharactersListaDataEntity: Codable {
    let results: [CharacterEntity]?
    let total: Int?
}

struct CharacterEntity: Codable {
    let id: UInt?
    let name: String?
    let description: String?
    let thumbnail: CharacterImageEntity?
}

struct CharacterImageEntity: Codable {
    enum CodingKeys: String, CodingKey {
        case path
        case extensionFile = "extension"
    }
    
    let path: String?
    let extensionFile: String?
}
