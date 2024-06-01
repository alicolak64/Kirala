//
//  UIViewController+Extension.swift
//  UniTurkey
//
//  Created by Ali Çolak on 7.04.2024.
//

import UIKit


extension UIViewController {
    /// Adds a bottom border to the view controller's view.
    func addBottomBorder() {
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = ColorPalette.border.color
        view.addSubview(border)
        
        NSLayoutConstraint.activate([
            border.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            border.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            border.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}


