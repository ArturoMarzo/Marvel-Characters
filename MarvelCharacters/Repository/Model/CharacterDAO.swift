struct CharactersListResponseDAO: Codable {
    let data: CharactersListaDataDAO?
}

struct CharactersListaDataDAO: Codable {
    let results: [CharacterDAO]?
    let total: Int?
}

struct CharacterDAO: Codable {
    let id: UInt?
    let name: String?
    let description: String?
    let thumbnail: CharacterImageDAO?
}

struct CharacterImageDAO: Codable {
    enum CodingKeys: String, CodingKey {
        case path
        case extensionFile = "extension"
    }
    
    let path: String?
    let extensionFile: String?
}
