import UIKit

// Using struct instead of a class to store the products information prevents mutability
struct CharacterDetailViewModel {
    let name: String
    let description: String?
    let thumbnail: String?
    let comics: [CharacterDetailComicDTO]?
    let availableComics: Int
    let series: [CharacterDetailSerieDTO]?
    let availableSeries: Int
    let stories: [CharacterDetailStoryDTO]?
    let availableStories: Int
    
    init(characterDetail: CharacterDetailDTO) {
        self.name = characterDetail.name
        self.description = characterDetail.description
        self.thumbnail = characterDetail.thumbnail
        self.comics = characterDetail.comics
        self.availableComics = characterDetail.availableComics
        self.series = characterDetail.series
        self.availableSeries = characterDetail.availableSeries
        self.stories = characterDetail.stories
        self.availableStories = characterDetail.availableStories
    }
}

class CharacterDetailDefaultViewModelBuilder: CharacterDetailViewModelBuilder {
    func buildViewModel(characterDetail: CharacterDetailDTO) -> CharacterDetailViewModel {
        return CharacterDetailViewModel(characterDetail: characterDetail)
    }
}
