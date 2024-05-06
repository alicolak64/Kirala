//
//  Symbolable.swift
//  UniTurkey
//
//  Created by Ali Çolak on 5.04.2024.
//

import UIKit

protocol Symbolable {
    // MARK: - Properties
    var symbolName: String { get }
    // MARK: - Methods
    func symbol(size: CGFloat, weight: UIImage.SymbolWeight) -> UIImage
}

// MARK: - Default Implementation
extension Symbolable {
    func symbol(size: CGFloat = 15, weight: UIImage.SymbolWeight = .medium) -> UIImage {
        let configuration = UIImage.SymbolConfiguration(pointSize: size, weight: weight)
        
        return UIImage(systemName: symbolName, withConfiguration: configuration)?
            .withRenderingMode(.alwaysTemplate) ?? UIImage()
    }
}
