struct CharacterDetailResponseDAO: Codable {
    let data: CharacterDetailDataDAO?
}

struct CharacterDetailDataDAO: Codable {
    let results: [CharacterDetailDAO]?
}

struct CharacterDetailDAO: Codable {
    let id: UInt?
    let name: String?
    let description: String?
    let thumbnail: CharacterDetailImageDAO?
    let comics: CharacterDetailComicsDAO?
    let series: CharacterDetailSeriesDAO?
    let stories: CharacterDetailStoriesDAO?
}

struct CharacterDetailImageDAO: Codable {
    enum CodingKeys: String, CodingKey {
        case path
        case extensionFile = "extension"
    }
    
    let path: String?
    let extensionFile: String?
}

struct CharacterDetailComicsDAO: Codable {
    let available: Int
    let items: [CharacterDetailComicDAO]
}

struct CharacterDetailComicDAO: Codable {
    let name: String
}

struct CharacterDetailSeriesDAO: Codable {
    let available: Int
    let items: [CharacterDetailSerieDAO]
}

struct CharacterDetailSerieDAO: Codable {
    let name: String
}

struct CharacterDetailStoriesDAO: Codable {
    let available: Int
    let items: [CharacterDetailStoryDAO]
}

struct CharacterDetailStoryDAO: Codable {
    let name: String
}
