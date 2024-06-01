//
//  NotificationsContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

protocol NotificationsBuilderProtocol {
    static func build(navigationController: UINavigationController?) -> UIViewController
}

enum NotificationsRoute {
    case back
    case login
}

protocol NotificationsRouterProtocol {
    func navigate(to route: NotificationsRoute)
}

protocol NotificationsViewModelProtocol {
    
    // MARK: Dependency Properties
    var delegate: NotificationsViewProtocol? { get set }
    
    // MARK: Lifecycle Methods
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidLayoutSubviews()
    func viewDidAppear()
    func viewDidDisappear()
        
    // MARK: Actions
    func didTapCancelButton()
    func didTapEmptyStateActionButton()
    
}


protocol NotificationsViewProtocol: AnyObject {
    
    // MARK: Methods
    
    func prepareNavigationBar()
    func prepareUI()
    func prepareConstraints()
    func addSwipeGesture()
    func removeSwipeGesture()
    func showEmptyState(with state: EmptyState)
    
}

