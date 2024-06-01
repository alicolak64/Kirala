//
//  ProductsHeaderCell.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import UIKit


/// Collection reusable view for the products header.
final class ProductsHeaderCell: UICollectionReusableView, ReusableView {
    
    // MARK: - Properties
    
    var presenter: ProductsHeaderPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = ColorText.quaternary.dynamicColor
        return label
    }()
    
    private lazy var allButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.common.localizedString(for: "ALL"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        button.setTitleColor(ColorPalette.appPrimary.dynamicColor, for: .normal)
        button.addTarget(self, action: #selector(didTapAllProducts), for: .touchUpInside)
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
        addSubview(titleLabel)
        addSubview(allButton)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        allButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            allButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            allButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapAllProducts() {
        presenter.didTapAllProducts()
    }
}

// MARK: - ProductsHeaderCellProtocol

extension ProductsHeaderCell: ProductsHeaderCellProtocol {
    
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    func setActionTitle(_ actionTitle: String) {
        allButton.setTitle(actionTitle, for: .normal)
    }
}
