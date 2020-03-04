import Foundation

class RepositoriesContainer {
    static let shared = RepositoriesContainer()

    lazy var characterRepository: CharacterRepository = {
        return CharacterRepositoryDefault()
    }()
}
