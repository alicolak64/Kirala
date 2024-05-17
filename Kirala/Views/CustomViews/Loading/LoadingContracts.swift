//
//  LoadingContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import Foundation

protocol LoadingViewProtocol {
    // MARK: - Methods
    func showLoading()
    func hideLoading()
}

enum LoadingState {
    // MARK: - Cases
    case loading
    case loaded
}
