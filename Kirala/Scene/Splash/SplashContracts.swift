//
//  SplashContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 13.05.2024.
//

import UIKit

protocol SplashBuilderProtocol {
    static func build() -> UIViewController
}

enum SplashRoute {
    case tabbar
}

protocol SplashRouterProtocol {
    func route(to route: SplashRoute)
}

protocol SplashViewModelProtocol {
    // MARK: - Dependency Properties
    var delegate: SplashViewProtocol? { get set }
    
    // MARK: - Lifecycle Methods
    func viewDidLoad()
    func viewDidLayoutSubviews()
}

typealias SplashAnimatableCompletion = () -> Void
typealias SplashAnimatableExecution = () -> Void

protocol SplashViewProtocol: AnyObject {
    
    func prepareUI()
    func prepareConstraints()
    
    func startAnimation(duration: TimeInterval, delay: TimeInterval, completion: @escaping SplashAnimatableCompletion)
        
}





