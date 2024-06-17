//
//  FavoriteCell.swift
//  Kirala
//
//  Created by Ali Çolak on 14.06.2024.
//

import UIKit

final class FavoriteCell: UICollectionViewCell, ReusableView {
    
    // MARK: - Properties
    
    var presenter: FavoriteCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.addCornerRadius(radius: 8)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorText.quaternary.dynamicColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
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
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Symbols.trash.symbol(size: 20), for: .normal)
        button.tintColor = ColorPalette.appPrimary.dynamicColor
        button.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        return button
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
        
        makeCardStyle()
                
        contentView.addSubviews([
            image,
            nameLabel,
            priceLabel,
            perDayLabel,
            deleteButton
        ])
        
        NSLayoutConstraint.activate([
            
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            
            nameLabel.topAnchor.constraint(equalTo: image.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            priceLabel.bottomAnchor.constraint(equalTo: image.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            perDayLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            perDayLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 5),
            
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deleteButton.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 20),
            deleteButton.heightAnchor.constraint(equalToConstant: 20),
            
        ])
        
    }
    
    // MARK: - Actions
    
    @objc private func didTapDeleteButton() {
        presenter.didTapDeleteButton()
    }
    
}

extension FavoriteCell: FavoriteCellViewProtocol {
    
    func setNameLabel(with totalString: String, brand: String, name: String) {
        nameLabel.setAttributedText(with: totalString, brand: brand, brandFont: UIFont.systemFont(ofSize: 10, weight: .bold), name: name, nameFont: UIFont.systemFont(ofSize: 10, weight: .regular))
    }
    
    func setImageURL(_ imageURL: URL) {
        image.kf.setImage(with: imageURL)
    }
    
    func setPriceLabel(_ price: String) {
        priceLabel.text = price
    }
    
    func setPerDayLabel(_ perDay: String) {
        perDayLabel.text = perDay
    }

    
}
