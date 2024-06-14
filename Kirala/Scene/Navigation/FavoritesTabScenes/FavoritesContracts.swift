//
//  FavoritesContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 14.06.2024.
//

import Foundation

enum FavoritesRoute {
    case auth
    case detail(DetailArguments)
    case home
}

protocol FavoritesRouterProtocol {
    func navigate(to route: FavoritesRoute)
}

protocol FavoritesViewModelProtocol {
    
    // MARK: Dependency Properties
    var delegate: FavoritesViewProtocol? { get set }
    
    // MARK: Lifecycle Methods
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidLayoutSubviews()
    func viewDidAppear()
    func viewDidDisappear()
    
    // MARK: Data Source Methods
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> FavoriteCellArguments?
    func didSelectRow(at indexPath: IndexPath)
    func heightForRow(at indexPath: IndexPath) -> CGFloat
    
    func searchTextDidChange(_ searchText: String)
        
    // MARK: Actions
    func didTapEmptyStateActionButton()
    func didTapDeleteButton(with indexPath: IndexPath)
    
    func refresh()
    
}


protocol FavoritesViewProtocol: AnyObject {
    
    // MARK: Methods
    
    func prepareNavigationBar()
    func prepareUI()
    func prepareConstraints()
    func showEmptyState(with state: EmptyState)
    func prepareTableView()
    func reloadTableView()
    func reloadRows(at indexPaths: [IndexPath])
    func deleteRows(at indexPaths: [IndexPath])
        
    func showLoading()
    func hideLoading(loadResult: LoadingResult)
    
    func addRefreshControl()
    func endRefreshing()
    
}
