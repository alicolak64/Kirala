//
//  LoadingContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import Foundation

/// Protocol defining the methods for showing and hiding a loading view.
protocol LoadingViewProtocol {
    // MARK: - Methods
    
    /// Shows the loading indicator.
    func showLoading()
    
    /// Hides the loading indicator.
    func hideLoading()
}

/// Enum representing the loading state.
enum LoadingState {
    // MARK: - Cases
    
    /// Indicates that loading is in progress.
    case loading
    
    /// Indicates that loading has completed.
    case loaded
}
