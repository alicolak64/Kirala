//
//  Symbolable.swift
//  UniTurkey
//
//  Created by Ali Çolak on 5.04.2024.
//

import UIKit

/// A protocol to provide a system symbol image.
protocol Symbolable {
    // MARK: - Properties
    
    /// The name of the system symbol.
    var symbolName: String { get }
    
    // MARK: - Methods
    
    /// Returns a configured system symbol image with the specified size and weight.
    /// - Parameters:
    ///   - size: The point size of the symbol image.
    ///   - weight: The weight of the symbol image.
    /// - Returns: A configured system symbol image.
    func symbol(size: CGFloat, weight: UIImage.SymbolWeight) -> UIImage
    
    /// Returns a system symbol image with default configuration.
    /// - Returns: A system symbol image.
    func symbol() -> UIImage
}

// MARK: - Default Implementation
extension Symbolable {
    func symbol(size: CGFloat = 15, weight: UIImage.SymbolWeight = .medium) -> UIImage {
        let configuration = UIImage.SymbolConfiguration(pointSize: size, weight: weight)
        
        return UIImage(systemName: symbolName, withConfiguration: configuration)?
            .withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
    
    func symbol() -> UIImage {
        UIImage(systemName: symbolName) ?? UIImage()
    }
}
