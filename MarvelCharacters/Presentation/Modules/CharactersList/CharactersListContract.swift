import Foundation
import UIKit

protocol CharactersListBuilder {
    func buildCharactersListModule() -> UIViewController?
}

protocol CharactersListInteractorManager {
    func characters(offset: Int, withCompletion completion: @escaping (_ characters: Characters?, _ error: Error?) -> Void)
}

protocol CharactersListPresenter: LoadingTableViewCellDelegate {
    func viewDidLoad()
    func loadingCellShown()
    func retryButtonPressed()
    func selectedCharacterWith(characterId: UInt)
}

protocol CharactersListView: class {
    func showHUD()
    func hideHUD()
    func hideErrorMessage()
    func displayCharacters(withViewModel viewModel: CharactersListViewModel)
    func displayErrorWith(message: String)
}

protocol CharactersListRouter {
    func navigateToCharacterDetailWith(characterId: UInt)
}

protocol CharactersListViewModelBuilder {
    func buildViewModel(characters: Characters) -> CharactersListViewModel
    func buildViewModelWith(viewModel: CharactersListViewModel, appendingCharacters characters: Characters) -> CharactersListViewModel
    func buildViewModel(characters: [CharacterViewModel], charactersListViewModelMode: CharactersListViewModelMode) -> CharactersListViewModel
}
