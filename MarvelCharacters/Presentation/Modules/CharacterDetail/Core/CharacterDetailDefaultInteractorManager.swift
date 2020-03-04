import Foundation

class CharacterDetailDefaultInteractorManager: CharacterDetailInteractorManager {
    private let characterId: UInt
    private let characterRepository: CharacterRepository
    
    init(characterId: UInt, characterRepository: CharacterRepository) {
        self.characterId = characterId
        self.characterRepository = characterRepository
    }
    
    func characterDetailWith(withCompletion completion: @escaping (_ character: CharacterDetail?, _ error: Error?) -> Void) {
        characterRepository.characterDetailWith(id: characterId, withCompletion: completion)
    }
}
