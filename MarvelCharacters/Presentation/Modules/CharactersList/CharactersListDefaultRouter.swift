import UIKit

class CharactersListDefaultRouter: CharactersListRouter {
    weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    // MARK - Navigation funcions
    func navigateToCharacterDetailWith(characterId: UInt) {
        guard let characterDetailViewController = characterDetailBuilder().buildCharacterDetailModuleWith(characterId: characterId) else { return }
        viewController?.navigationController?.pushViewController(characterDetailViewController, animated: true)
    }
    
    // MARK: - Private
    private func characterDetailBuilder() -> CharacterDetailBuilder {
        return Container.shared.characterDetailBuilder()
    }
}
