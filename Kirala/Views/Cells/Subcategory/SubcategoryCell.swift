//
//  SubcategoryCell.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import UIKit
import Kingfisher

/// Collection view cell for displaying a subcategory.
final class SubcategoryCell: UICollectionViewCell, ReusableView {
    
    
    // MARK: - Properties
    
    var presenter: SubcategoryCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    // MARK: - UI Components
    
    private lazy var imageContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorBackground.primary.dynamicColor
        view.addRoundedBorder(width: 0.5, color: ColorPalette.border.dynamicColor)
        view.addShadow(color: ColorPalette.border.dynamicColor, opacity: 0.5, offset: .zero, radius: 15)
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorText.quaternary.dynamicColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 2
        return label
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
        imageContainerView.addSubview(imageView)
        
        contentView.addSubviews([
            imageContainerView,
            nameLabel
        ])
        
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            
            imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: imageContainerView.widthAnchor, multiplier: 0.8),
            
            nameLabel.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    

}

// MARK: - SubcategoryCellViewProtocol

extension SubcategoryCell: SubcategoryCellViewProtocol {
    
    
    func setName(_ name: String) {
        nameLabel.text = name
    }
    
    func setImageURL(_ imageURL: URL) {
        imageView.setImage(with: imageURL)
    }
    
    
}
