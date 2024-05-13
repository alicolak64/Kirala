//
//  SplashViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 13.05.2024.
//

import Foundation

final class SplashViewModel: SplashViewModelProtocol {
    
    // MARK: - Dependency Properties
    
    weak var delegate: SplashViewProtocol?
    private let router: SplashRouterProtocol
    
    // MARK: - Properties
    private let animationDuration: TimeInterval = 1.5
    private let animationDelay: TimeInterval = 0.5
    
    // MARK: - Init
    
    init(router: SplashRouterProtocol) {
        self.router = router
    }
    
    func viewDidLoad() {
        delegate?.prepareUI()
        delegate?.startAnimation(duration: animationDuration, delay: animationDelay) { [weak self] in
            self?.router.route(to: .tabbar)
        }
    }
    
    func viewDidLayoutSubviews() {
        delegate?.prepareConstraints()
    }
    
}
