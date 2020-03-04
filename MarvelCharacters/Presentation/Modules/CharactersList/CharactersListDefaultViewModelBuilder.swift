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
    
    init(characters: Characters, charactersListViewModelMode: CharactersListViewModelMode) {
        var charactersViewModel = [CharacterViewModel]()
        for character in characters.characters {
            charactersViewModel.append(CharacterViewModel(character: character))
        }
        
        self.characters = charactersViewModel
        self.charactersListViewModelMode = charactersListViewModelMode
    }
    
    init(charactersViewModel: [CharacterViewModel], charactersListViewModelMode: CharactersListViewModelMode) {
        self.characters = charactersViewModel
        self.charactersListViewModelMode = charactersListViewModelMode
    }
    
    func viewModelAppending(characters: Characters, charactersListViewModelMode: CharactersListViewModelMode) -> CharactersListViewModel {
        var charactersViewModel = self.characters
        for character in characters.characters {
            charactersViewModel.append(CharacterViewModel(character: character))
        }
        
        let charactersListViewModel = CharactersListViewModel(charactersViewModel: charactersViewModel, charactersListViewModelMode: charactersListViewModelMode)
        
        return charactersListViewModel
    }
}

struct CharacterViewModel {
    let id: UInt
    let name: String
    let description: String?
    let thumbnail: String?
    
    init(character: Character) {
        id = character.id
        name = character.name
        description = character.description
        thumbnail = character.thumbnail
    }
}

class CharactersListDefaultViewModelBuilder: CharactersListViewModelBuilder {
    func buildViewModel(characters: Characters) -> CharactersListViewModel {
        var charactersListViewModelMode = CharactersListViewModelMode.allDataLoaded
        if let totalOfCharacters = characters.total, totalOfCharacters > characters.characters.count {
            charactersListViewModelMode = .loading
        }
        
        return CharactersListViewModel(characters: characters, charactersListViewModelMode: charactersListViewModelMode)
    }
    
    func buildViewModelWith(viewModel: CharactersListViewModel, appendingCharacters characters: Characters) -> CharactersListViewModel {
        var charactersListViewModelMode = CharactersListViewModelMode.allDataLoaded
        if let totalOfCharacters = characters.total,
            totalOfCharacters > (characters.characters.count + viewModel.characters.count) {
            charactersListViewModelMode = .loading
        }
        
        return viewModel.viewModelAppending(characters: characters, charactersListViewModelMode: charactersListViewModelMode)
    }
    
    func buildViewModel(characters: [CharacterViewModel], charactersListViewModelMode: CharactersListViewModelMode) -> CharactersListViewModel {
        return CharactersListViewModel(charactersViewModel: characters, charactersListViewModelMode: charactersListViewModelMode)
    }
}
