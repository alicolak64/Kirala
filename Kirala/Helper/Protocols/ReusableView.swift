//
//  ReusableView.swift
//  UniTurkey
//
//  Created by Ali Çolak on 5.04.2024.
//

import UIKit

/// A protocol that provides a reusable identifier for UIView subclasses.
protocol ReusableView {
    
    // MARK: - Static Properties
    
    /// A unique identifier for the reusable view.
    static var identifier: String { get }
}

// MARK: - Default Implementation

extension ReusableView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
