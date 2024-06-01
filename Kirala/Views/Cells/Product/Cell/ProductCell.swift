//
//  ProductCell.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import UIKit
import Kingfisher

/// Collection view cell for displaying a product.
final class ProductCell: UICollectionViewCell, ReusableView {
    
    // MARK: - Properties
    
    var presenter: ProductCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    // MARK: - UI Components
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
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
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorPalette.appPrimary.dynamicColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    private lazy var perDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorText.quaternary.dynamicColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
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
        contentView.addSubviews([imageView, favoriteButton, nameLabel, priceLabel, perDayLabel])
        
        contentView.backgroundColor = ColorBackground.primary.dynamicColor
        contentView.addRoundedBorder(width: 0.5, color: ColorPalette.border.dynamicColor)
        contentView.addShadow(color: ColorPalette.border.dynamicColor, opacity: 0.5, offset: .zero, radius: 10)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            favoriteIcon.centerXAnchor.constraint(equalTo: favoriteButton.centerXAnchor),
            favoriteIcon.centerYAnchor.constraint(equalTo: favoriteButton.centerYAnchor),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 20),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            perDayLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor),
            perDayLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 5),
            perDayLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor)
            
            
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapFavoriteButton() {
        presenter.didTapFavoriteButton()
    }
}

// MARK: - ProductCellViewProtocol

extension ProductCell: ProductCellViewProtocol {
    
    func setName(with totalString: String, brand: String, name: String) {
        nameLabel.setAttributedText(with: totalString, brand: brand, brandFont: UIFont.systemFont(ofSize: 10, weight: .bold), name: name, nameFont: UIFont.systemFont(ofSize: 10, weight: .regular))
    }
    
    func setImageURL(_ imageURL: URL) {
        imageView.kf.setImage(with: imageURL)
    }
    
    func setPrice(_ price: String) {
        priceLabel.text = price
    }
    
    func setPerDayString(_ perDayString: String) {
        perDayLabel.text = perDayString
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

