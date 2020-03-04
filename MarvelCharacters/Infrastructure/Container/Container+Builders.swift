import Foundation

extension Container {
    func charactersListBuilder() -> CharactersListBuilder {
        return CharactersListDefaultBuilder()
    }
    
    func characterDetailBuilder() -> CharacterDetailBuilder {
        return CharacterDetailDefaultBuilder()
    }
}
