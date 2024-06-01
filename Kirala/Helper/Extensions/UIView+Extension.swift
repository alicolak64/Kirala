//
//  UIView+Extensions.swift
//  OmdbApp
//
//  Created by Ali Çolak on 15.11.2023.
//

import UIKit

extension UIView {
    
    // MARK: - Add Subviews
    
    /// Adds multiple subviews to the view.
    /// - Parameter views: An array of UIViews to add as subviews.
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
    
    /// Adds multiple subviews to the view.
    /// - Parameter views: A variadic list of UIViews to add as subviews.
    func addSubviews(_ views: UIView...) {
        addSubviews(views)
    }
    
    // MARK: - Add Constraints
    
    /// Adds and activates multiple constraints.
    /// - Parameter constraints: An array of NSLayoutConstraints to add and activate.
    func addConstraints(_ constraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Adds and activates multiple constraints.
    /// - Parameter constraints: A variadic list of NSLayoutConstraints to add and activate.
    func addConstraints(_ constraints: NSLayoutConstraint...) {
        addConstraints(constraints)
    }
    
    // MARK: - Add Border, Corner Radius, Shadow
    
    /// Adds a border to the view.
    /// - Parameters:
    ///   - width: The width of the border.
    ///   - color: The color of the border.
    func addBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    /// Adds a corner radius to the view.
    /// - Parameter radius: The radius of the corner.
    func addCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    /// Adds a rounded border with a default corner radius of 10.
    /// - Parameters:
    ///   - width: The width of the border.
    ///   - color: The color of the border.
    func addRoundedBorder(width: CGFloat, color: UIColor) {
        addBorder(width: width, color: color)
        addCornerRadius(radius: 10)
    }
    
    /// Adds a shadow to the view.
    /// - Parameters:
    ///   - color: The color of the shadow.
    ///   - opacity: The opacity of the shadow.
    ///   - offset: The offset of the shadow.
    ///   - radius: The radius of the shadow.
    private func addShadowWithParametres(color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    /// Adds a default shadow to the view.
    /// - Parameters:
    ///   - color: The color of the shadow (default is black).
    ///   - opacity: The opacity of the shadow (default is 0.5).
    ///   - offset: The offset of the shadow (default is .zero).
    ///   - radius: The radius of the shadow (default is 10).
    func addShadow(color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = .zero, radius: CGFloat = 10) {
        addShadowWithParametres(color: color, opacity: opacity, offset: offset, radius: radius)
    }
    
    // MARK: - Add Top Shadow
    
    /// Adds a shadow to the top of the view.
    /// - Parameters:
    ///   - color: The color of the shadow.
    ///   - opacity: The opacity of the shadow.
    ///   - offset: The offset of the shadow.
    ///   - radius: The radius of the shadow.
    func addTopShadow(color: UIColor = .black, opacity: Float = 0.5, offset: CGSize = CGSize(width: 0, height: -2), radius: CGFloat = 10) {
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(rect: bounds).cgPath
        shadowLayer.fillColor = backgroundColor?.cgColor
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = UIBezierPath(rect: CGRect(x: bounds.origin.x, y: bounds.origin.y - offset.height, width: bounds.width, height: offset.height)).cgPath
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = radius
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func makeCardStyle() {
        backgroundColor = ColorBackground.primary.dynamicColor
        layer.cornerRadius = 20
        layer.shadowColor = ColorPalette.black.dynamicColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
    }
    
    func makeFooterStyle() {
        backgroundColor = ColorBackground.primary.dynamicColor
        addTopBorder(color: ColorPalette.lightBorder.dynamicColor, width: 0.5)
        addTopShadow()
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
    }
    
    func addTopBorder(color: UIColor, width: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        addSubview(border)
        
        NSLayoutConstraint.activate([
            border.topAnchor.constraint(equalTo: topAnchor),
            border.leadingAnchor.constraint(equalTo: leadingAnchor),
            border.trailingAnchor.constraint(equalTo: trailingAnchor),
            border.heightAnchor.constraint(equalToConstant: width)
        ])
    }
    
    
}
