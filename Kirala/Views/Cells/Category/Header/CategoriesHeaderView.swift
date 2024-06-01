//
//  CategoriesHeaderView.swift
//  Kirala
//
//  Created by Ali Çolak on 18.05.2024.
//

import UIKit

/// Reusable view for displaying categories header with a button and separator.
final class CategoriesHeaderView: UICollectionReusableView, ReusableView {
    
    // MARK: - Properties
    
    var presenter: CategoriesHeaderViewPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    // MARK: - UI Components
    
    private lazy var allCategoriesButton: UIButton = {
        let button = UIButton(type: .system)
        
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .leading
        config.imagePadding = 2
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var attributes = attributes
            attributes.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            return attributes
        }
        
        button.configuration = config
        button.tintColor = ColorText.primary.dynamicColor
        button.layer.borderWidth = 1
        button.layer.borderColor = ColorPalette.border.dynamicColor.cgColor
        button.backgroundColor = ColorBackground.primary.dynamicColor
        button.addTarget(self, action: #selector(didTapAllCategoriesButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.border.dynamicColor
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
    
    // MARK: - Setup UI
    
    private func setupUI() {
        addSubviews([allCategoriesButton, separator])
        
        NSLayoutConstraint.activate([
            allCategoriesButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            allCategoriesButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            allCategoriesButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            separator.leadingAnchor.constraint(equalTo: allCategoriesButton.trailingAnchor, constant: 10),
            separator.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            separator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            separator.widthAnchor.constraint(equalToConstant: 1)
        ])
        
        backgroundColor = ColorBackground.primary.dynamicColor
    }
    
    // MARK: - Actions
    
    @objc private func didTapAllCategoriesButton() {
        presenter.didTapAllCategoriesButton()
    }
}

// MARK: - CategoriesHeaderViewProtocol

extension CategoriesHeaderView: CategoriesHeaderViewProtocol {
    func setButtonSymbol(_ symbol: any Symbolable) {
        allCategoriesButton.configuration?.image = symbol.symbol(size: 12, weight: .regular)
        allCategoriesButton.setNeedsUpdateConfiguration()
    }
    
    func setButtonTitle(_ title: String) {
        allCategoriesButton.configuration?.title = title
        allCategoriesButton.setNeedsUpdateConfiguration()
    }
}
