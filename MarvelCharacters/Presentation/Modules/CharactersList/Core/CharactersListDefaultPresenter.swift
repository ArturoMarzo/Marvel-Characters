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
    
    // Called when the last cell with a spinner is shown to load more characters
    func loadingCellShown() {
        guard let viewModel = self.viewModel else { // Just in case viewModel is not set
            self.view?.displayErrorWith(message: NSLocalizedString("error_generic_error", comment: ""))
            return
        }
        
        retrieveCharacters(offset: viewModel.characters.count)
    }
    
    // User presses a button in the an error view to retry the retrieving of data from the server
    func retryButtonPressed() {
        view?.hideErrorMessage()
        view?.showHUD()
        retrieveCharacters(offset: 0)
    }
    
    // User selected a character from the list
    func selectedCharacterWith(characterId: UInt) {
        router.navigateToCharacterDetailWith(characterId: characterId)
    }
    
    // MARK: - Private
    func retrieveCharacters(offset: Int) {
        interactorManager.characters(offset: offset) { [weak self] (characters, error) in
            // If presenter has ben freed before retrieving the data it is not necessary to continue interacting with the view
            guard let self = self else { return }
            guard error == nil, let characters = characters else { // Error in request
                if let viewModel = self.viewModel {
                    // There is data previously retrieved. If request failed show retry option in cell
                    let newViewModel = self.viewModelBuilder.buildViewModel(characters: viewModel.characters, charactersListViewModelMode: .error)
                    self.view?.displayCharacters(withViewModel: newViewModel)
                } else {
                    // No data previously requested. Show error view
                    if let error = error, error.code != HTTPRequestService.genericErrorCode {
                        self.view?.displayErrorWith(message: error.localizedDescription)
                    } else {
                        self.view?.displayErrorWith(message: NSLocalizedString("error_generic_error", comment: ""))
                    }
                }
                
                return
            }
            
            let viewModel: CharactersListViewModel
            if let currentViewModel = self.viewModel { // Append new data to the list
                // Use a class to build the data that is going to be shown in the view
                viewModel = self.viewModelBuilder.buildViewModelWith(viewModel: currentViewModel, appendingCharacters: characters)
            } else { // First data to list
                // Use a class to build the data that is going to be shown in the view
                viewModel = self.viewModelBuilder.buildViewModel(characters: characters)
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
        
        // Use a class to build the data that is going to be shown in the view
        let newViewModel = self.viewModelBuilder.buildViewModel(characters: viewModel.characters, charactersListViewModelMode: .loading)
        self.view?.displayCharacters(withViewModel: newViewModel)
        
        retrieveCharacters(offset: newViewModel.characters.count)
    }
}
