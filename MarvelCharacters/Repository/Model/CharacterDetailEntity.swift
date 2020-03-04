struct CharacterDetailResponseEntity: Codable {
    let data: CharacterDetailDataEntity?
}

struct CharacterDetailDataEntity: Codable {
    let results: [CharacterDetailEntity]?
}

struct CharacterDetailEntity: Codable {
    let id: UInt?
    let name: String?
    let description: String?
    let thumbnail: CharacterDetailImageEntity?
    let comics: CharacterDetailComicsEntity?
    let series: CharacterDetailSeriesEntity?
    let stories: CharacterDetailStoriesEntity?
}

struct CharacterDetailImageEntity: Codable {
    enum CodingKeys: String, CodingKey {
        case path
        case extensionFile = "extension"
    }
    
    let path: String?
    let extensionFile: String?
}

struct CharacterDetailComicsEntity: Codable {
    let available: Int
    let items: [CharacterDetailComicEntity]
}

struct CharacterDetailComicEntity: Codable {
    let name: String
}

struct CharacterDetailSeriesEntity: Codable {
    let available: Int
    let items: [CharacterDetailSerieEntity]
}

struct CharacterDetailSerieEntity: Codable {
    let name: String
}

struct CharacterDetailStoriesEntity: Codable {
    let available: Int
    let items: [CharacterDetailStoryEntity]
}

struct CharacterDetailStoryEntity: Codable {
    let name: String
}
