//
//  FilterView.swift
//  Kirala
//
//  Created by Ali Çolak on 30.05.2024.
//

import UIKit

final class FilterView: UIView, FilterViewProtocol {
    
    private var viewModel: FilterViewModel {
        didSet {
            viewModel.view = self
        }
    }
    
    private lazy var sortButton: UIButton = {
        let button = UIButton(type: .system)
        
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .leading
        config.imagePadding = 8
        
        config.attributedTitle = AttributedString(Localization.filter.localizedString(for: "SORT"), attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor: ColorText.primary.dynamicColor]))
        config.image = Symbols.arrowUpArrowDown.symbol(size: 10)
        
        button.configuration = config
        button.tintColor = ColorPalette.appPrimary.dynamicColor
        button.addRoundedBorder(width: 1, color: ColorPalette.border.dynamicColor)
        button.backgroundColor = ColorBackground.primary.dynamicColor
        button.addTarget(self, action: #selector(didTapSortButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .leading
        config.imagePadding = 8
        
        config.attributedTitle = AttributedString(Localization.filter.localizedString(for: "FILTER"), attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor: ColorText.primary.dynamicColor]))
        config.image = Symbols.sliderHorizontal3.symbol(size: 12)
        
        button.configuration = config
        button.tintColor = ColorPalette.appPrimary.dynamicColor
        button.addRoundedBorder(width: 1, color: ColorPalette.border.dynamicColor)
        button.backgroundColor = ColorBackground.primary.dynamicColor
        button.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var headerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(viewModel: FilterViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        headerContainer.addSubviews([sortButton, filterButton])
        addSubviews([headerContainer])
        prepareConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func prepareConstraints() {
        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: topAnchor),
            headerContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            sortButton.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16),
            sortButton.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
            
            filterButton.leadingAnchor.constraint(equalTo: sortButton.trailingAnchor, constant: 16),
            filterButton.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
        ])
    }
    
    @objc private func didTapSortButton() {
        viewModel.didTapSortButton()
    }
    
    @objc private func didTapFilterButton() {
        viewModel.didTapFilterButton()
    }
    
    func setSortButtonTitle(_ title: String) {
        
    }
    
    func setFilterButtonTitle(_ title: String) {
        
    }
    
}
