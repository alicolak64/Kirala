//
//  SplashContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 13.05.2024.
//

import UIKit

/// A protocol for building the splash screen view controller.
protocol SplashBuilderProtocol {
    /// Builds and returns the splash screen view controller.
    /// - Returns: The splash screen view controller.
    static func build() -> UIViewController
}

/// An enum representing the routes from the splash screen.
enum SplashRoute {
    /// Route to the tab bar.
    case tabbar
}

/// A protocol for routing from the splash screen.
protocol SplashRouterProtocol {
    /// Routes to a specified destination.
    /// - Parameter route: The destination route.
    func route(to route: SplashRoute)
}

/// A protocol for the splash screen view model.
protocol SplashViewModelProtocol {
    // MARK: - Dependency Properties
    /// The delegate for the splash screen view.
    var delegate: SplashViewProtocol? { get set }
    
    // MARK: - Lifecycle Methods
    /// Called when the view is loaded.
    func viewDidLoad()
    
    /// Called when the view's subviews are laid out.
    func viewDidLayoutSubviews()
}

/// A type alias for the completion block of a splash animation.
typealias SplashAnimatableCompletion = () -> Void

/// A type alias for the execution block of a splash animation.
typealias SplashAnimatableExecution = () -> Void

/// A protocol for the splash screen view.
protocol SplashViewProtocol: AnyObject {
    
    /// Prepares the UI for the splash screen.
    func prepareUI()
    
    /// Prepares the constraints for the splash screen.
    func prepareConstraints()
    
    /// Starts the splash screen animation.
    /// - Parameters:
    ///   - duration: The duration of the animation.
    ///   - delay: The delay before the animation starts.
    ///   - completion: The completion block to be executed after the animation ends.
    func startAnimation(duration: TimeInterval, delay: TimeInterval, completion: @escaping SplashAnimatableCompletion)
}
