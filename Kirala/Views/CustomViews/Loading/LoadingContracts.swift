//
//  LoadingContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import Foundation


enum LoadingResult {
    case success
    case failure
    case none
}

/// Protocol defining the methods for showing and hiding a loading view.
protocol LoadingViewProtocol {
    // MARK: - Methods
    
    /// Shows the loading indicator.
    func showLoading()
    
    func hideLoading(loadResult: LoadingResult)
}
