import UIKit

class CharactersListDefaultBuilder: BaseBuilder, CharactersListBuilder {
    var router: CharactersListRouter?
    var interactorManager: CharactersListInteractorManager?
    var presenter: CharactersListPresenter?
    var view: CharactersListView?
    var viewModelBuilder: CharactersListViewModelBuilder?

    // MARK: - CharactersListBuilder protocol
    func buildCharactersListModule() -> UIViewController? {
        buildView()
        buildRouter()
        buildInteractor()
        buildViewModelBuilder()
        buildPresenter()
        buildCircularDependencies()
        return view as? UIViewController
    }

    // MARK: - Private
    private func buildView() {
        view = CharactersListViewController()
    }

    private func buildRouter() {
        guard let view = self.view as? UIViewController else {
            assert(false, "View has to be a UIViewController")
            return
        }
        router = CharactersListDefaultRouter(viewController: view)
    }

    private func buildInteractor() {
        interactorManager = CharactersListDefaultInteractorManager(characterRepository: repositoriesContainer.characterRepository)
    }
    
    private func buildViewModelBuilder() {
        viewModelBuilder = CharactersListDefaultViewModelBuilder()
    }

    private func buildPresenter() {
        guard let interactorManager = interactorManager,
            let router = router,
            let view = view,
            let viewModelBuilder = viewModelBuilder  else {
            assert(false, "No dependencies available")
            return
        }
        presenter = CharactersListDefaultPresenter(interactorManager: interactorManager,
                                                   router: router,
                                                   view: view,
                                                   viewModelBuilder: viewModelBuilder)
    }

    private func buildCircularDependencies() {
        guard let presenter = presenter, let view = view as? CharactersListViewController else {
            assert(false, "No dependencies available")
            return
        }
        view.presenter = presenter
    }
}
