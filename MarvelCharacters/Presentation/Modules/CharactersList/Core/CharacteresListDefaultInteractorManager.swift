import Foundation

class CharactersListDefaultInteractorManager: CharactersListInteractorManager {
    private let characterRepository: CharacterRepository
    
    init(characterRepository: CharacterRepository) {
        self.characterRepository = characterRepository
    }
    
    func characters(offset: Int, withCompletion completion: @escaping (_ characters: CharactersDTO?, _ error: Error?) -> Void) {
        characterRepository.characters(offset: offset, withCompletion: completion)
    }
}
