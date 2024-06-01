//
//  EmptyStateContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit



/// Protocol to handle the output from the empty state view.
protocol EmptyStateViewDelegate: AnyObject {
    func didTapActionButton()
}

/// States for the empty state view visibility.
enum EmptyStateState {
    /// Indicates that the view is hidden.
    case hidden
    /// Indicates that the view is visible.
    case visible
}

/// Protocol for the empty state view.
protocol EmptyStateViewProtocol {
    /// Delegate to handle output events.
    var delegate: EmptyStateViewDelegate? { get set }
    
    /// Configures the view with the specified state.
    /// - Parameter state: The state to configure the view.
    func configure(with state: EmptyState)
    
    /// Shows the view with optional animation.
    /// - Parameter withAnimation: Whether to show with animation.
    func show(withAnimation: Bool)
    
    /// Hides the view with optional animation.
    /// - Parameter withAnimation: Whether to hide with animation.
    func hide(withAnimation: Bool)
}
