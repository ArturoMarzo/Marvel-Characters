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
    
    func retryButtonPressed() {
        view?.hideErrorMessage()
        view?.showHUD()
        retrieveCharacterData()
    }
    
    // MARK: - Private
    func retrieveCharacterData() {
        interactorManager.characterDetailWith { [weak self] (characterDetailDTO, error) in
            guard let self = self else { return }
            guard error == nil, let characterDetailDTO = characterDetailDTO else {
                if let error = error, error.code != HTTPRequestService.genericErrorCode {
                    self.view?.displayErrorWith(message: error.localizedDescription)
                } else {
                    self.view?.displayErrorWith(message: NSLocalizedString("error_generic_error", comment: ""))
                }
                
                return
            }
            
            let viewModel = self.viewModelBuilder.buildViewModel(characterDetail: characterDetailDTO)
            self.viewModel = viewModel
            self.view?.hideHUD()
            self.view?.displayCharacterDetail(withViewModel: viewModel)
        }
    }
}
