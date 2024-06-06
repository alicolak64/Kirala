//
//  SearchRouter.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

final class SearchRouter: SearchRouterProtocol {
    
    // MARK: - Properties
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func navigate(to route: SearchRoute) {
        switch route {
        case .detail(_):
            let detailNavController = UINavigationController()
            let detailViewController = DetailBuilder.build(rootNavigationController: navigationController, navigationController: detailNavController)
            detailNavController.viewControllers = [detailViewController]
            detailNavController.modalPresentationStyle = .fullScreen
            navigationController?.present(detailNavController, animated: true, completion: nil)
        case .back:
            navigationController?.popViewController(animated: true)
        case .twoStepBack:
            if let viewControllers = navigationController?.viewControllers, viewControllers.count >= 3 {
                var newStack = viewControllers
                newStack.removeLast(2)
                navigationController?.setViewControllers(newStack, animated: true)
            }
        case .textSearch(let query):
            let searchViewController = SearchBuilder.build(navigationController: navigationController, searchOption: .textSearch(query))
            navigationController?.pushViewController(searchViewController, animated: true)
        case .searchEditing(let query):
            let searchViewController = SearchBuilder.build(navigationController: navigationController, searchOption: .searchEdtiting(query))
            navigationController?.pushViewController(searchViewController, animated: false)
        case .auth:
            let authNavController = UINavigationController()
            let authViewController = AuthBuilder.build(rootViewController: navigationController, navigationController: authNavController)
            authNavController.viewControllers = [authViewController]
            authNavController.modalPresentationStyle = .fullScreen
            navigationController?.present(authNavController, animated: true, completion: nil)
        case .sort(let arguments, let viewModel):
            let sortViewController = SortPopupView()
            let presenter = SortPopupPresenter(view: sortViewController, arguments: arguments)
            sortViewController.presenter = presenter
            presenter.delegate = viewModel
            navigationController?.present(sortViewController, animated: true)
        case .pushSearchable(let arguments, let viewModel):
            let searchablePopupViewController = SearchablePopupView()
            let presenter = SearchablePopupPresenter(view: searchablePopupViewController, arguments: arguments)
            searchablePopupViewController.presenter = presenter
            presenter.delegate = viewModel
            navigationController?.present(searchablePopupViewController, animated: true)
        case .pushMinMax(let arguments, let viewModel):
            let minMaxPopupViewController = MinMaxPopupView()
            let presenter = MinMaxPopupPresenter(view: minMaxPopupViewController, arguments: arguments)
            minMaxPopupViewController.presenter = presenter
            presenter.delegate = viewModel
            navigationController?.present(minMaxPopupViewController, animated: true)
        }
        
    }
    
}

final class FilterRouter: FilterRouterProtocol {
    
    // MARK: - Properties
    private weak var rootNavigationController: UINavigationController?
    private let navigationController: BottomPopupNavigationController?
    private var initalHeight: CGFloat = 0
    
    init(rootNavigationController: UINavigationController?) {
        self.rootNavigationController = rootNavigationController
        navigationController = BottomPopupNavigationController(nibName: nil, bundle: nil)
    }
    
    func navigate(to route: FilterRoute) {
        switch route {
        case .initial(let arguments, let height, let viewModel):
            initalHeight = height
            let filterViewController = FilterPopupView()
            let presenter = FilterPopupPresenter(view: filterViewController, arguments: arguments)
            filterViewController.presenter = presenter
            presenter.delegate = viewModel
            navigationController?.updatePopupHeight(to: height)
            navigationController?.viewControllers = [filterViewController]
            rootNavigationController?.present(navigationController!, animated: true, completion: nil)
        case .dismiss:
            rootNavigationController?.dismiss(animated: true, completion: nil)
        case .back:
            if navigationController?.viewControllers.count == 0 || navigationController?.viewControllers.count == 1 {
                rootNavigationController?.dismiss(animated: true, completion: nil)
            } else {
                navigationController?.popViewController(animated: true)
            }
        case .pushSearchable(let arguments, let viewModel):
            let searchablePopupViewController = SearchablePopupView()
            let presenter = SearchablePopupPresenter(view: searchablePopupViewController, arguments: arguments)
            searchablePopupViewController.presenter = presenter
            presenter.delegate = viewModel
            navigationController?.pushViewController(searchablePopupViewController, animated: true)
        case .pushMinMax(let arguments, let viewModel):
            let minMaxPopupViewController = MinMaxPopupView()
            let presenter = MinMaxPopupPresenter(view: minMaxPopupViewController, arguments: arguments)
            minMaxPopupViewController.presenter = presenter
            presenter.delegate = viewModel
            navigationController?.pushViewController(minMaxPopupViewController, animated: true)
        }
    }
}
