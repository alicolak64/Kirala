//
//  CategoryCell.swift
//  Kirala
//
//  Created by Ali Çolak on 18.05.2024.
//

import UIKit

/// Collection view cell for displaying a category.
final class CategoryCell: UICollectionViewCell, ReusableView {
    
    // MARK: - Properties
    
    var presenter: CategoryCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    private var leadingConstraints: NSLayoutConstraint?
    
    // MARK: - UI Components
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorText.primary.dynamicColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var verticalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.appPrimary.dynamicColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        categoryLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        categoryLabel.text = nil
        categoryLabel.textColor = ColorText.primary.dynamicColor
        leadingConstraints?.constant = 2
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        contentView.addSubviews([verticalSeparator, categoryLabel])
        
        NSLayoutConstraint.activate([
            verticalSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalSeparator.widthAnchor.constraint(equalToConstant: 2),
            verticalSeparator.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            categoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        leadingConstraints = categoryLabel.leadingAnchor.constraint(equalTo: verticalSeparator.trailingAnchor, constant: 2)
        leadingConstraints?.isActive = true
    }
}

// MARK: - CategoryCellViewProtocol

extension CategoryCell: CategoryCellViewProtocol {
    
    func setCategoryName(_ name: String) {
        categoryLabel.text = name
    }
    
    func setLeadingConstraint(_ constant: CGFloat) {
        leadingConstraints?.constant = constant
    }
    
    func showSeperator() {
        verticalSeparator.isHidden = false
    }
    
    func hideSeperator() {
        verticalSeparator.isHidden = true
    }
    
    func prepareHomeCategoryStyle() {
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
    }
    
    func prepareSearchCategoryStyle() {
        contentView.layer.cornerRadius = 0
        contentView.layer.borderWidth = 0
        categoryLabel.numberOfLines = 0
        categoryLabel.textAlignment = .left
    }
    
    func prepareNonSelectedHomeCategoryStyle() {
        contentView.backgroundColor = ColorBackground.primary.dynamicColor
        categoryLabel.textColor = ColorText.primary.dynamicColor
        contentView.layer.borderColor = ColorPalette.border.dynamicColor.cgColor
    }
    
    func prepareNonSelectedSearchCategoryStyle() {
        contentView.backgroundColor = ColorBackground.secondary.dynamicColor
        categoryLabel.textColor = ColorText.tertiary.dynamicColor
    }
    
    func prepareSelectedHomeCategoryStyle() {
        contentView.backgroundColor = ColorPalette.appPrimary.dynamicColor
        categoryLabel.textColor = ColorText.white.dynamicColor
        contentView.layer.borderColor = ColorPalette.appPrimary.dynamicColor.cgColor
    }
    
    func prepareSelectedSearchCategoryStyle() {
        contentView.backgroundColor = ColorBackground.primary.dynamicColor
        categoryLabel.textColor = ColorPalette.appPrimary.dynamicColor
        verticalSeparator.backgroundColor = ColorPalette.appPrimary.dynamicColor
        categoryLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
    
}
