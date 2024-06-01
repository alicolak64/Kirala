//
//  SearchProductCell.swift
//  Kirala
//
//  Created by Ali Çolak on 25.05.2024.
//

import UIKit

/// Collection view cell for displaying a product.
final class SearchProductCell: UICollectionViewCell, ReusableView {
    
    // MARK: - Properties
    
    var presenter: SearchProductCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var imageSliderViewTapGesture: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageSliderViewTapped))
        return gestureRecognizer
    }()
    
    private lazy var imageSliderView: ImageSliderView = {
        let view = ImageSliderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorText.quaternary.dynamicColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var ratingView: RatingView = {
        let view = RatingView()
        view.configure(with: .small, type: .starAndCount)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorPalette.appPrimary.dynamicColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private lazy var favoriteButton: UIView = {
        let view = UIView()
        view.backgroundColor = ColorBackground.primary.dynamicColor
        view.addRoundedBorder(width: 0.5, color: ColorPalette.border.dynamicColor)
        view.addShadow(color: ColorPalette.border.dynamicColor, opacity: 0.5, offset: .zero, radius: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapFavoriteButton)))
        return view
    }()
    
    private lazy var favoriteIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var favoriteButtonAnimation: CAKeyframeAnimation = {
        let animation = CAKeyframeAnimation(keyPath: FavoriteAnimation.keyPath)
        animation.keyTimes = FavoriteAnimation.keyTimes
        animation.duration = FavoriteAnimation.duration
        return animation
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        favoriteButton.addSubview(favoriteIcon)
        contentView.addSubviews([imageSliderView, favoriteButton, nameLabel, ratingView, priceLabel])
        
        contentView.backgroundColor = ColorBackground.primary.dynamicColor
        contentView.addRoundedBorder(width: 0.5, color: ColorPalette.border.dynamicColor)
        contentView.addShadow(color: ColorPalette.border.dynamicColor, opacity: 0.5, offset: .zero, radius: 10)
        
        NSLayoutConstraint.activate([
            imageSliderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageSliderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageSliderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageSliderView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            favoriteIcon.centerXAnchor.constraint(equalTo: favoriteButton.centerXAnchor),
            favoriteIcon.centerYAnchor.constraint(equalTo: favoriteButton.centerYAnchor),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 20),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: imageSliderView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            ratingView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            
            priceLabel.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            
            
        ])
        
    }
    
    // MARK: - Actions
    
    @objc private func didTapFavoriteButton() {
        presenter.didTapFavoriteButton()
    }
    
    @objc private func imageSliderViewTapped() {
        presenter.didTapImageSliderView()
    }
    
}

// MARK: - SearchProductCellViewProtocol

extension SearchProductCell: SearchProductCellViewProtocol {
    
    func addImageSliderViewTapGesture() {
        imageSliderView.addGestureRecognizer(imageSliderViewTapGesture)
        imageSliderView.isUserInteractionEnabled = true
    }
    
    func setImageURLs(_ imageURLs: [String], loopingEnabled: Bool) {
        let imageSliderPresenter = ImageSliderViewPresenter(imageUrls: imageURLs,
                                                            loopingEnabled: loopingEnabled,
                                                            view: imageSliderView)
        imageSliderView.presenter = imageSliderPresenter
    }
    
    func setName(with totalString: String, brand: String, name: String) {
        nameLabel.setAttributedText(with: totalString, brand: brand, brandFont: UIFont.systemFont(ofSize: 10, weight: .bold), name: name, nameFont: UIFont.systemFont(ofSize: 10, weight: .regular))
    }
    
    func setReviewCount(_ count: Int) {
        ratingView.setTotalRatingCount(count)
    }
    
    func setReviewRating(_ rating: Double) {
        ratingView.setRating(rating)
    }
    
    func setPrice(_ price: String) {
        priceLabel.text = price
    }
    
    func setFavoritedIcon(animated: Bool = false) {
        if animated {
            favoriteIcon.image = Symbols.heartFill.symbol()
            favoriteIcon.tintColor = ColorPalette.appPrimary.dynamicColor
            favoriteButtonAnimation.values = FavoriteAnimation.getValues(state: .favorited)
            // finish animation run updateFavoriteFeature(isFavorite: !isFavorite)
            favoriteButton.layer.add(favoriteButtonAnimation, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + FavoriteAnimation.duration) { [weak self] in
                self?.favoriteIcon.image = Symbols.heartFill.symbol()
                self?.favoriteIcon.tintColor = ColorPalette.appPrimary.dynamicColor
            }
        } else {
            favoriteIcon.image = Symbols.heartFill.symbol()
            favoriteIcon.tintColor = ColorPalette.appPrimary.dynamicColor
        }
    }
    
    func setNonfavoritedIcon(animated: Bool = false) {
        if animated {
            favoriteIcon.image = Symbols.heartFill.symbol()
            favoriteIcon.tintColor = ColorPalette.appPrimary.dynamicColor
            favoriteButtonAnimation.values = FavoriteAnimation.getValues(state: .nonFavorited)
            // finish animation run updateFavoriteFeature(isFavorite: !isFavorite)
            favoriteButton.layer.add(favoriteButtonAnimation, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + FavoriteAnimation.duration) { [weak self] in
                self?.favoriteIcon.image = Symbols.heart.symbol()
                self?.favoriteIcon.tintColor = ColorText.primary.dynamicColor
            }
        } else {
            favoriteIcon.image = Symbols.heart.symbol()
            favoriteIcon.tintColor = ColorText.primary.dynamicColor
        }
    }
    
}
