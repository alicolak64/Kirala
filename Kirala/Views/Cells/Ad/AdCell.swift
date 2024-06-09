//
//  AdCell.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import UIKit

final class AdCell: UITableViewCell, ReusableView {
    
    // MARK: - Properties
    
    var presenter: AdCellPresenterProtocol! {
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
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Symbols.chevronRight.symbol()
        imageView.tintColor = ColorPalette.appPrimary.dynamicColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.lightBorder.dynamicColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Setup UI
    
    private func setupUI() {
        
        contentView.addSubviews([
            bottomSeparator,
            image,
            nameLabel,
            priceLabel,
            perDayLabel,
            arrowImageView
        ])
        
        NSLayoutConstraint.activate([
            
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 18),
            
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            image.widthAnchor.constraint(equalToConstant: 60),
            image.heightAnchor.constraint(equalToConstant: 60),
            
            nameLabel.topAnchor.constraint(equalTo: image.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -10),
            
            priceLabel.bottomAnchor.constraint(equalTo: image.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            perDayLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor),
            perDayLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 5),
            
            bottomSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 0.5),
            
        ])
        
    }
    
}

extension AdCell: AdCellViewProtocol {
    
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
    
    func showBottomSeparator() {
        bottomSeparator.isHidden = false
    }
    
}
