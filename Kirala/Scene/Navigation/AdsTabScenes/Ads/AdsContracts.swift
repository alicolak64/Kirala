//
//  AdsContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import UIKit

struct EditAddAdArguments {
    let id: String
}

enum AddAddRouteOption {
    case addAd
    case editAd(EditAddAdArguments)
}

enum AdsRoute {
    case auth
    case add(AddAddRouteOption)
}

protocol AdsRouterProtocol {
    func navigate(to route: AdsRoute)
}

protocol AdsViewModelProtocol {
    
    // MARK: Dependency Properties
    var delegate: AdsViewProtocol? { get set }
    
    // MARK: Lifecycle Methods
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidLayoutSubviews()
    func viewDidAppear()
    func viewDidDisappear()
    
    // MARK: Data Source Methods
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> AdCellArguments?
    func didSelectRow(at indexPath: IndexPath)
    func heightForRow(at indexPath: IndexPath) -> CGFloat
        
    // MARK: Actions
    func didTapEmptyStateActionButton()
    func didTapAddAdButton()
    
}


protocol AdsViewProtocol: AnyObject {
    
    // MARK: Methods
    
    func prepareNavigationBar()
    func prepareUI()
    func prepareConstraints()
    func addAddAdButtonNavigationItem()
    func showEmptyState(with state: EmptyState)
    func prepareTableView()
    func reloadTableView()
    func reloadRows(at indexPaths: [IndexPath])
    
}
