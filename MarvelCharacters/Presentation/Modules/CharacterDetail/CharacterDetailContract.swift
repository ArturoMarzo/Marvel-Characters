import Foundation
import UIKit

/*
By defining a contract it is easier to see the relationship between the
presenter, the view, the router... in VIPER It also makes easier to test the different layers
*/

protocol CharacterDetailBuilder {
    func buildCharacterDetailModuleWith(characterId: UInt) -> UIViewController?
}

protocol CharacterDetailInteractorManager {
    func characterDetailWith(withCompletion completion: @escaping (_ character: CharacterDetail?, _ error: Error?) -> Void)
}

protocol CharacterDetailPresenter {
    func viewDidLoad()
    func retryButtonPressed()
}

protocol CharacterDetailView: class {
    func showHUD()
    func hideHUD()
    func hideErrorMessage()
    func displayCharacterDetail(withViewModel viewModel: CharacterDetailViewModel)
    func displayErrorWith(message: String)
}

protocol CharacterDetailRouter {

}

protocol CharacterDetailViewModelBuilder {
    func buildViewModel(characterDetail: CharacterDetail) -> CharacterDetailViewModel
}
