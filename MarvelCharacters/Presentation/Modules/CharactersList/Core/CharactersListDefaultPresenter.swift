import Foundation

// MARK: - Main Class
class CharactersListDefaultPresenter: CharactersListPresenter {
    private let interactorManager: CharactersListInteractorManager
    private let router: CharactersListRouter
    private let viewModelBuilder: CharactersListViewModelBuilder
    private weak var view: CharactersListView?
    
    private var viewModel: CharactersListViewModel?

    init(interactorManager: CharactersListInteractorManager,
         router: CharactersListRouter,
         view: CharactersListView,
         viewModelBuilder: CharactersListViewModelBuilder) {
        self.interactorManager = interactorManager
        self.router = router
        self.view = view
        self.viewModelBuilder = viewModelBuilder
    }

    // MARK: - CharactersListPresenter
    func viewDidLoad() {
        view?.showHUD()
        retrieveCharacters(offset: 0)
    }
    
    func loadingCellShown() {
        guard let viewModel = self.viewModel else { // Just in case viewModel is not set
            self.view?.displayErrorWith(message: NSLocalizedString("error_generic_error", comment: ""))
            return
        }
        
        retrieveCharacters(offset: viewModel.characters.count)
    }
    
    func retryButtonPressed() {
        view?.hideErrorMessage()
        view?.showHUD()
        retrieveCharacters(offset: 0)
    }
    
    func selectedCharacterWith(characterId: UInt) {
        router.navigateToCharacterDetailWith(characterId: characterId)
    }
    
    // MARK: - Private
    func retrieveCharacters(offset: Int) {
        interactorManager.characters(offset: offset) { [weak self] (charactersDTO, error) in
            guard let self = self else { return }
            guard error == nil, let charactersDTO = charactersDTO else {
                if let viewModel = self.viewModel {
                    // If request failed show retry option in cell
                    let newViewModel = self.viewModelBuilder.buildViewModel(characters: viewModel.characters, charactersListViewModelMode: .error)
                    self.view?.displayCharacters(withViewModel: newViewModel)
                } else {
                    if let error = error, error.code != HTTPRequestService.genericErrorCode {
                        self.view?.displayErrorWith(message: error.localizedDescription)
                    } else {
                        self.view?.displayErrorWith(message: NSLocalizedString("error_generic_error", comment: ""))
                    }
                }
                
                return
            }
            
            let viewModel: CharactersListViewModel
            if let currentViewModel = self.viewModel {
                viewModel = self.viewModelBuilder.buildViewModelWith(viewModel: currentViewModel, appendingCharacters: charactersDTO)
            } else {
                viewModel = self.viewModelBuilder.buildViewModel(characters: charactersDTO)
            }
            
            self.viewModel = viewModel
            self.view?.hideHUD()
            self.view?.displayCharacters(withViewModel: viewModel)
        }
    }
}

extension CharactersListDefaultPresenter: LoadingTableViewCellDelegate {
    func retryButtonPressed(loadingTableViewCell: LoadingTableViewCell) {
        guard let viewModel = self.viewModel else { return }
        
        let newViewModel = self.viewModelBuilder.buildViewModel(characters: viewModel.characters, charactersListViewModelMode: .loading)
        self.view?.displayCharacters(withViewModel: newViewModel)
        
        retrieveCharacters(offset: newViewModel.characters.count)
    }
}
