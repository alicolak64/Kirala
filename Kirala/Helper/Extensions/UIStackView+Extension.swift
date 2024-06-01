//
//  UIStackView+Extension.swift
//  Kirala
//
//  Created by Ali Çolak on 18.05.2024.
//

import UIKit

extension UIStackView {
    func addHorizontalSeparators(color: UIColor) {
        var i = self.arrangedSubviews.count
        while i >= 0 {
            let separator = createHorizontalSeparator(color: color)
            insertArrangedSubview(separator, at: i)
            separator.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
            i -= 1
        }
    }
    
    private func createHorizontalSeparator(color: UIColor) -> UIView {
        let separator = UIView()
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = color
        return separator
    }
    
    func addVerticalSeparators(color: UIColor) {
        var i = self.arrangedSubviews.count
        while i >= 0 {
            let separator = createVerticalSeparator(color: color)
            insertArrangedSubview(separator, at: i)
            separator.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
            i -= 1
        }
    }
    
    private func createVerticalSeparator(color: UIColor) -> UIView {
        let separator = UIView()
        separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separator.backgroundColor = color
        return separator
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}

