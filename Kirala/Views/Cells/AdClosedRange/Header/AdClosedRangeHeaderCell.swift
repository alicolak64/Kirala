//
//  AdClosedRangeHeader.swift
//  Kirala
//
//  Created by Ali Çolak on 9.06.2024.
//

import UIKit

/// Collection reusable view for the products header.
final class AdClosedRangeHeaderCell: UITableViewHeaderFooterView, ReusableView {
    
    // MARK: - Properties
    
    var presenter: AdClosedRangeHeaderPresenterProtocol! {
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
    
    private lazy var addClosedRangeButton: UIButton = {
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
        button.addTarget(self, action: #selector(didTapAddClosedRangeButton), for: .touchUpInside)
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
            addClosedRangeButton
        ])
                
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            addClosedRangeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addClosedRangeButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapAddClosedRangeButton() {
        presenter.didTapAddClosedRangeButton()
    }
}

// MARK: - AdClosedRangeHeaderCellProtocol

extension AdClosedRangeHeaderCell: AdClosedRangeHeaderCellProtocol {
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setButtonTitle(_ title: String) {
        addClosedRangeButton.configuration?.title = title
        addClosedRangeButton.setNeedsUpdateConfiguration()
    }
    
    func setButtonSymbol(_ symbol: Symbolable) {
        addClosedRangeButton.configuration?.image = symbol.symbol(size: 12, weight: .regular)
        addClosedRangeButton.setNeedsUpdateConfiguration()
    }
    
    
}
