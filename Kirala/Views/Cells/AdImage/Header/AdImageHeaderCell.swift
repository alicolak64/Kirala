//
//  AdImageHeaderView.swift
//  Kirala
//
//  Created by Ali Çolak on 9.06.2024.
//

import UIKit

/// Collection reusable view for the products header.
final class AdImageHeaderCell: UITableViewHeaderFooterView, ReusableView {
    
    // MARK: - Properties
    
    var presenter: AdImageHeaderPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = ColorText.primary.dynamicColor
        return label
    }()
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton(type: .system)
        
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .leading
        config.imagePadding = 10
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var attributes = attributes
            attributes.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            attributes.foregroundColor = ColorText.primary.dynamicColor
            return attributes
        }
        
        button.configuration = config
        button.tintColor = ColorPalette.appPrimary.dynamicColor
        button.backgroundColor = ColorBackground.primary.dynamicColor
        button.addTarget(self, action: #selector(didTapAddImageButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        addSubviews([
            titleLabel,
            addImageButton
        ])
                
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            addImageButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addImageButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapAddImageButton() {
        presenter.didTapAddImageButton()
    }
}

// MARK: - AdImageHeaderCellProtocol

extension AdImageHeaderCell: AdImageHeaderCellProtocol {
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setButtonTitle(_ title: String) {
        addImageButton.configuration?.title = title
        addImageButton.setNeedsUpdateConfiguration()
    }
    
    func setButtonSymbol(_ symbol: Symbolable) {
        addImageButton.configuration?.image = symbol.symbol(size: 12, weight: .regular)
        addImageButton.setNeedsUpdateConfiguration()
    }
    
    
}
