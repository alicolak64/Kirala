//
//  FilterHeaderCell.swift
//  Kirala
//
//  Created by Ali Çolak on 3.06.2024.
//

import UIKit

final class FilterHeaderCell: UICollectionViewCell, ReusableView {
    
    var presenter: FilterHeaderCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = ColorText.primary.dynamicColor
        return label
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Symbols.chevronDown.symbol(size: 12)
        imageView.tintColor = ColorPalette.appPrimary.dynamicColor
        return imageView
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
        contentView.addSubviews([nameLabel, chevronImageView])
        contentView.addRoundedBorder(width: 1, color: ColorPalette.border.dynamicColor)
        contentView.backgroundColor = ColorBackground.primary.dynamicColor

        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    
}

extension FilterHeaderCell: FilterHeaderCellViewProtocol {
    
    func setTitleLabel(_ title: String) {
        nameLabel.text = title
    }
    
    func prepareAvaliableItemStyle() {
        contentView.backgroundColor = ColorPalette.appTertiary.dynamicColor
        contentView.addRoundedBorder(width: 1, color: ColorPalette.appPrimary.dynamicColor)
    }
    
    func prepareNonAvaliableItemStyle() {
        contentView.backgroundColor = ColorBackground.primary.dynamicColor
        contentView.addRoundedBorder(width: 1, color: ColorPalette.border.dynamicColor)
    }
    
    func prepareExpandedStyle() {
        chevronImageView.image = Symbols.chevronUp.symbol(size: 12)
    }
    
    func prepareCollapsedStyle() {
        chevronImageView.image = Symbols.chevronDown.symbol(size: 12)
    }
    
}
