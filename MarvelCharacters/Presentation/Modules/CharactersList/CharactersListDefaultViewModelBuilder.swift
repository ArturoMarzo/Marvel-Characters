import UIKit

enum CharactersListViewModelMode {
    case loading
    case allDataLoaded
    case error
}

// Using struct instead of a class to store the products information prevents mutability
struct CharactersListViewModel {
    var characters: [CharacterViewModel]
    var charactersListViewModelMode: CharactersListViewModelMode
    
    init(charactersDTO: CharactersDTO, charactersListViewModelMode: CharactersListViewModelMode) {
        var characters = [CharacterViewModel]()
        for character in charactersDTO.characters {
            characters.append(CharacterViewModel(character: character))
        }
        
        self.characters = characters
        self.charactersListViewModelMode = charactersListViewModelMode
    }
    
    init(charactersViewModel: [CharacterViewModel], charactersListViewModelMode: CharactersListViewModelMode) {
        self.characters = charactersViewModel
        self.charactersListViewModelMode = charactersListViewModelMode
    }
    
    func viewModelAppending(charactersDTO: CharactersDTO, charactersListViewModelMode: CharactersListViewModelMode) -> CharactersListViewModel {
        var characters = self.characters
        for character in charactersDTO.characters {
            characters.append(CharacterViewModel(character: character))
        }
        
        let charactersListViewModel = CharactersListViewModel(charactersViewModel: characters, charactersListViewModelMode: charactersListViewModelMode)
        
        return charactersListViewModel
    }
}

struct CharacterViewModel {
    let id: UInt
    let name: String
    let description: String?
    let thumbnail: String?
    
    init(character: CharacterDTO) {
        id = character.id
        name = character.name
        description = character.description
        thumbnail = character.thumbnail
    }
}

class CharactersListDefaultViewModelBuilder: CharactersListViewModelBuilder {
    func buildViewModel(characters: CharactersDTO) -> CharactersListViewModel {
        var charactersListViewModelMode = CharactersListViewModelMode.allDataLoaded
        if let totalOfCharacters = characters.total, totalOfCharacters > characters.characters.count {
            charactersListViewModelMode = .loading
        }
        
        return CharactersListViewModel(charactersDTO: characters, charactersListViewModelMode: charactersListViewModelMode)
    }
    
    func buildViewModelWith(viewModel: CharactersListViewModel, appendingCharacters charactersDTO: CharactersDTO) -> CharactersListViewModel {
        var charactersListViewModelMode = CharactersListViewModelMode.allDataLoaded
        if let totalOfCharacters = charactersDTO.total,
            totalOfCharacters > (charactersDTO.characters.count + viewModel.characters.count) {
            charactersListViewModelMode = .loading
        }
        
        return viewModel.viewModelAppending(charactersDTO: charactersDTO, charactersListViewModelMode: charactersListViewModelMode)
    }
    
    func buildViewModel(characters: [CharacterViewModel], charactersListViewModelMode: CharactersListViewModelMode) -> CharactersListViewModel {
        return CharactersListViewModel(charactersViewModel: characters, charactersListViewModelMode: charactersListViewModelMode)
    }
}
