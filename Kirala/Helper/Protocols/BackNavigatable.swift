//
//  BackNavigatable.swift
//  Kirala
//
//  Created by Ali Çolak on 20.05.2024.
//

import UIKit

/// A protocol to add a custom back button and a bottom border to view controllers.
@objc protocol BackNavigatable {
    /// Called when the back button is tapped.
    func backButtonTapped()
}

// MARK: - Default Implementation

extension BackNavigatable where Self: UIViewController {
    
    /// Adds a custom back button to the view controller's navigation item.
    func addBackButton() {
        let backButton = UIButton(type: .custom)
        
        let backIcon = Symbols.arrowLeft.symbol()
        backButton.setImage(backIcon, for: .normal)
        backButton.tintColor = ColorText.primary.dynamicColor
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem
    }
    
}
