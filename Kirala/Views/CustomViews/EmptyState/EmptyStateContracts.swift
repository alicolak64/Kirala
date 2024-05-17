//
//  EmptyStateContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

enum EmptyStateViewOutput {
    case didTapButton
}

protocol EmptyStateViewDelegate: AnyObject {
    func handleOutput(_ output: EmptyStateViewOutput)
}

enum EmptyStateState {
    case hidden
    case visible
}

protocol EmptyStateViewProtocol {
    var delegate: EmptyStateViewDelegate? { get set }
    func configure(with state: EmptyStateProtocol)
    func show(withAnimation: Bool)
    func hide(withAnimation: Bool)
}
