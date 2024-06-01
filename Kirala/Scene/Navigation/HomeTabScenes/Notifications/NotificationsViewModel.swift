//
//  NotificationsViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import Foundation

final class NotificationsViewModel {
    
    // MARK: - Dependency Properties
    
    weak var delegate: NotificationsViewProtocol?
    
    private let router: NotificationsRouterProtocol
    private let authService: AuthService
    
    // MARK: - Initializers
    
    init(router: NotificationsRouterProtocol, authService: AuthService) {
        self.router = router
        self.authService = authService
    }
    
}

extension NotificationsViewModel: NotificationsViewModelProtocol {

    // MARK: - Lifecycle Methods
    
    func viewDidLoad() {
        delegate?.prepareNavigationBar()
        delegate?.prepareUI()
    }
    
    func viewWillAppear() {
        guard authService.isLoggedIn else {
            delegate?.showEmptyState(with: .noLoginNotification)
            return
        }
    }
    
    func viewDidAppear() {
        delegate?.addSwipeGesture()
    }
    
    func viewDidDisappear() {
        delegate?.removeSwipeGesture()
    }
    
    func viewDidLayoutSubviews() {
        delegate?.prepareConstraints()
    }
    
    // MARK: - Actions
    
    func didTapCancelButton() {
        router.navigate(to: .back)
    }
    
    func didTapEmptyStateActionButton() {
        router.navigate(to: .auth)
    }
    
}
