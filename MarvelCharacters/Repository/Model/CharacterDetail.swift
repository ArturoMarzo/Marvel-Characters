import UIKit

struct CharacterDetail {
    let id: UInt
    let name: String
    let description: String?
    let thumbnail: String?
    let comics: [CharacterDetailComic]?
    let availableComics: Int
    let series: [CharacterDetailSerie]?
    let availableSeries: Int
    let stories: [CharacterDetailStory]?
    let availableStories: Int
    
    // Receives the struct generated by the character detail service parser
    init?(characterDetailEntity: CharacterDetailEntity) {
        guard let id  = characterDetailEntity.id, let name = characterDetailEntity.name else { return nil }
        self.id = id
        self.name = name
        description = characterDetailEntity.description
        if let path = characterDetailEntity.thumbnail?.path,
            let extensionFile = characterDetailEntity.thumbnail?.extensionFile {
            thumbnail = "\(path).\(extensionFile)"
        } else {
            thumbnail = nil
        }
        
        if let comics = characterDetailEntity.comics?.items {
            var comicsDetail = [CharacterDetailComic]()
            for comic in comics {
                comicsDetail.append(CharacterDetailComic(name: comic.name))
            }
            self.comics = comicsDetail
            self.availableComics = characterDetailEntity.comics?.available ?? 0
        } else {
            self.comics = [CharacterDetailComic]()
            self.availableComics = 0
        }
        
        if let series = characterDetailEntity.series?.items {
            var seriesDetail = [CharacterDetailSerie]()
            for serie in series {
                seriesDetail.append(CharacterDetailSerie(name: serie.name))
            }
            self.series = seriesDetail
            self.availableSeries = characterDetailEntity.series?.available ?? 0
        } else {
            self.series = [CharacterDetailSerie]()
            self.availableSeries = 0
        }
        
        if let stories = characterDetailEntity.stories?.items {
            var storysDetail = [CharacterDetailStory]()
            for story in stories {
                storysDetail.append(CharacterDetailStory(name: story.name))
            }
            self.stories = storysDetail
            self.availableStories = characterDetailEntity.stories?.available ?? 0
        } else {
            self.stories = [CharacterDetailStory]()
            self.availableStories = 0
        }
    }
}

struct CharacterDetailComic {
    let name: String
}

struct CharacterDetailSerie {
    let name: String
}

struct CharacterDetailStory {
    let name: String
}
