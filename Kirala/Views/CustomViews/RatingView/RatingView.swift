//
//  RatingView.swift
//  Kirala
//
//  Created by Ali Çolak on 25.05.2024.
//

import UIKit

enum RatingViewStyle {
    case small
    case medium
    case large
}

enum RatingViewType {
    case starAndCount
    case starAndCountAndRating
}

protocol RatingViewProtocol: UIView {
    func configure(with style: RatingViewStyle, type: RatingViewType)
    func setRating(_ rating: Double)
    func setTotalRatingCount(_ totalRating: Int)
}

final class RatingView: UIView {
    
    var ratingViewLeadingConstraint: NSLayoutConstraint?
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.black.dynamicColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorText.primary.dynamicColor
        return label
    }()
    
    private lazy var ratingView: CosmosView = {
        let view = CosmosView()
        view.settings.updateOnTouch = false
        view.settings.fillMode = .precise
        view.settings.starMargin = 2
        view.settings.textColor = ColorPalette.black.dynamicColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupView() {
        
        backgroundColor = ColorBackground.primary.dynamicColor
        
        addSubviews([
            ratingLabel,
            ratingView
        ])
        
        NSLayoutConstraint.activate([
            
            ratingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            ratingLabel.topAnchor.constraint(equalTo: topAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            ratingView.topAnchor.constraint(equalTo: topAnchor),
            ratingView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ratingView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        ratingViewLeadingConstraint = ratingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0)
        ratingViewLeadingConstraint?.isActive = true
        
    }
    
    
}

extension RatingView: RatingViewProtocol {
    
    func configure(with style: RatingViewStyle, type: RatingViewType) {
        switch style {
        case .small:
            ratingView.settings.starSize = 13
            ratingView.settings.textFont = UIFont.systemFont(ofSize: 10, weight: .regular)
            ratingLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        case .medium:
            ratingView.settings.starSize = 16
            ratingView.settings.textFont = UIFont.systemFont(ofSize: 12, weight: .regular)
            ratingLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        case .large:
            ratingView.settings.starSize = 20
            ratingView.settings.textFont = UIFont.systemFont(ofSize: 16, weight: .regular)
            ratingLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        }
        
        switch type {
        case .starAndCount:
            ratingLabel.isHidden = true
            ratingViewLeadingConstraint?.constant = 0
        case .starAndCountAndRating:
            ratingLabel.isHidden = false
            ratingViewLeadingConstraint?.constant = 25
        }
        
    }
    
    func setRating(_ rating: Double) {
        ratingView.rating = rating
        ratingLabel.text = String(format: "%.1f", rating)
    }
    
    func setTotalRatingCount(_ totalRatingCount: Int) {
        ratingView.text = "(\(totalRatingCount))"
    }
    
}
