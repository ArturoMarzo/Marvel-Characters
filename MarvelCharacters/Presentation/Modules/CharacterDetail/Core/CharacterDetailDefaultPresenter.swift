import Foundation

// MARK: - Main Class
class CharacterDetailDefaultPresenter: CharacterDetailPresenter {
    private let interactorManager: CharacterDetailInteractorManager
    private let router: CharacterDetailRouter
    private let viewModelBuilder: CharacterDetailViewModelBuilder
    private weak var view: CharacterDetailView?
    
    private var viewModel: CharacterDetailViewModel?

    init(interactorManager: CharacterDetailInteractorManager,
         router: CharacterDetailRouter,
         view: CharacterDetailView,
         viewModelBuilder: CharacterDetailViewModelBuilder) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
        self.viewModelBuilder = viewModelBuilder
    }

    // MARK: - CharacterDetailPresenter
    func viewDidLoad() {
        view?.showHUD()
        retrieveCharacterData()
    }
    
    // User selected a character from the list
    func retryButtonPressed() {
        view?.hideErrorMessage()
        view?.showHUD()
        retrieveCharacterData()
    }
    
    // MARK: - Private
    func retrieveCharacterData() {
        interactorManager.characterDetailWith { [weak self] (characterDetail, error) in
            // If presenter has ben freed before retrieving the data it is not necessary to continue interacting with the view
            guard let self = self else { return }
            guard error == nil, let characterDetail = characterDetail else { // Error in request
                if let error = error, error.code != HTTPRequestService.genericErrorCode {
                    self.view?.displayErrorWith(message: error.localizedDescription)
                } else {
                    self.view?.displayErrorWith(message: NSLocalizedString("error_generic_error", comment: ""))
                }
                
                return
            }
            
            // Use a class to build the data that is going to be shown in the view
            let viewModel = self.viewModelBuilder.buildViewModel(characterDetail: characterDetail)
            self.viewModel = viewModel
            self.view?.hideHUD()
            self.view?.displayCharacterDetail(withViewModel: viewModel)
        }
    }
}
