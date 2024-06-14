//
//  LoadingState.swift
//  Kirala
//
//  Created by Ali Çolak on 5.06.2024.
//

import Foundation

enum LoadingState {
    case loading
    case loaded(LoadingResult)
    
    func isLoading() -> Bool {
        if case .loading = self {
            return true
        }
        return false
    }
}
