//
//  UIView+Extensions.swift
//  OmdbApp
//
//  Created by Ali Çolak on 15.11.2023.
//

import UIKit

extension UIView {
    
    // MARK: - Add Subviews
    
    func addSubviews(_ views: [UIView]){
        views.forEach { view in
            self.addSubview(view)
        }
    }
    
    func addSubviews(_ views: UIView...){
        addSubviews(views)
    }
    
    // MARK: - Add Constraints
    
    func addConstraints(_ constraints: [NSLayoutConstraint]){
        NSLayoutConstraint.activate(constraints)
    }
    
    func addConstraints(_ constraints: NSLayoutConstraint...){
        addConstraints(constraints)
    }
    
    // MARK: - Add Border, Corner Radius, Shadow
    
    func addBorder(width: CGFloat, color: UIColor){
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func addCornerRadius(radius: CGFloat){
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func addRoundedBorder(width: CGFloat, color: UIColor){
        addBorder(width: width, color: color)
        addCornerRadius(radius: 10)
    }
    
    func addShadow(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat){
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    func addShadow(){
        addShadow(color: .black, opacity: 0.5, offset: .zero, radius: 10)
    }
    
}
