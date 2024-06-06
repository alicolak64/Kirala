//
//  FilterView.swift
//  Kirala
//
//  Created by Ali Çolak on 30.05.2024.
//

import UIKit

final class FilterView: UIView, FilterViewProtocol {
    
    private var viewModel: FilterViewModel
    
    private lazy var sortButton: UIButton = {
        let button = UIButton(type: .system)
        
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .leading
        config.imagePadding = 8
        
        config.attributedTitle = AttributedString(Strings.Filter.sort.localized, attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor: ColorText.primary.dynamicColor]))
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
        
        config.attributedTitle = AttributedString(Strings.Filter.filter.localized, attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor: ColorText.primary.dynamicColor]))
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
    
    private lazy var headerSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorPalette.border.dynamicColor
        view.isHidden = true
        return view
    }()
    
    private lazy var badgeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorPalette.appPrimary.dynamicColor
        view.addCornerRadius(radius: 9)
        view.isHidden = true
        return view
    }()
    
    private lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = ColorText.white.dynamicColor
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ColorBackground.primary.dynamicColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var headeerViewWidthConstraint: NSLayoutConstraint?
    
    
    init(viewModel: FilterViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        badgeView.addSubviews([badgeLabel])
        headerContainer.addSubviews([sortButton, filterButton, badgeView, headerSeparator])
        addSubviews([headerContainer, collectionView])
        prepareConstraints()
        prepareCollectionView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func prepareConstraints() {
        
        headeerViewWidthConstraint = headerContainer.widthAnchor.constraint(equalToConstant: 190)
        headeerViewWidthConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: topAnchor),
            headerContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            sortButton.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16),
            sortButton.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
            sortButton.heightAnchor.constraint(equalTo: headerContainer.heightAnchor, multiplier: 0.6),
            
            filterButton.leadingAnchor.constraint(equalTo: sortButton.trailingAnchor, constant: 8),
            filterButton.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
            filterButton.heightAnchor.constraint(equalTo: headerContainer.heightAnchor, multiplier: 0.6),

            
            badgeView.topAnchor.constraint(equalTo: filterButton.topAnchor, constant: -4),
            badgeView.trailingAnchor.constraint(equalTo: filterButton.trailingAnchor, constant: 4),
            badgeView.widthAnchor.constraint(equalToConstant: 18),
            badgeView.heightAnchor.constraint(equalToConstant: 18),
            
            badgeLabel.centerXAnchor.constraint(equalTo: badgeView.centerXAnchor),
            badgeLabel.centerYAnchor.constraint(equalTo: badgeView.centerYAnchor),
            
            headerSeparator.leadingAnchor.constraint(equalTo: filterButton.trailingAnchor, constant: 5),
            headerSeparator.widthAnchor.constraint(equalToConstant: 1),
            headerSeparator.heightAnchor.constraint(equalTo: filterButton.heightAnchor , multiplier: 0.9),
            headerSeparator.centerYAnchor.constraint(equalTo: headerContainer.centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: headerContainer.trailingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
        
        
    }
    
    func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FilterHeaderCell.self)
    }
    
    @objc private func didTapSortButton() {
        viewModel.didTapSortButton()
    }
    
    @objc private func didTapFilterButton() {
        viewModel.didTapFilterButton()
    }
    
    func setSortButtonTitle(_ title: String) {
        sortButton.configuration?.attributedTitle = AttributedString(title, attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor: ColorText.primary.dynamicColor]))
    }
    
    func setFilterButtonTitle(_ title: String) {
        filterButton.configuration?.attributedTitle = AttributedString(title, attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 14, weight: .regular), .foregroundColor: ColorText.primary.dynamicColor]))
    }
    
    func setBadgeCount(_ count: Int) {
        if count > 0 {
            badgeView.isHidden = false
            count > 99 ? (badgeLabel.text = "99+") : (badgeLabel.text = "\(count)")
            filterButton.bringSubviewToFront(badgeView)
            filterButton.backgroundColor = ColorPalette.appTertiary.dynamicColor
            filterButton.addRoundedBorder(width: 1, color: ColorPalette.appPrimary.dynamicColor)
        } else {
            badgeView.isHidden = true
        }
    }
    
    func removeBadge() {
        badgeView.isHidden = true
        filterButton.addRoundedBorder(width: 1, color: ColorPalette.border.dynamicColor)
        filterButton.backgroundColor = ColorBackground.primary.dynamicColor
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func reloadItems(at indexPaths: [IndexPath]) {
        collectionView.reloadItems(at: indexPaths)
    }
    
    func reloadExpandState(indexPath: IndexPath, expandState: ExpandState) {
        if let cell = collectionView.cellForItem(at: indexPath) as? FilterHeaderCell {
            cell.presenter.updateExpandIcon(state: expandState)
        }
    }
    
    func closeExpandedCell(type: FilterType) {
        viewModel.closeExpandedCell(type: type)
    }
    
    func reloadFilterCell(type: FilterType) {
        viewModel.reloadFilterCell(type: type)
    }
    
    private func updateButtonsVisibility(isVisible: Bool = true) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            if isVisible {
                self.setSortButtonToIconOnly()
                self.setFilterButtonToIconOnly()
                self.headerSeparator.isHidden = false
                self.headeerViewWidthConstraint?.constant = 120
            } else {
                self.setSortButtonToFullTitle()
                self.setFilterButtonToFullTitle()
                self.headerSeparator.isHidden = true
                self.headeerViewWidthConstraint?.constant = 190
            }
            self.layoutIfNeeded()
        }
    }

    private func setSortButtonToIconOnly() {
        UIView.transition(with: sortButton, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            guard let self = self else { return }
            self.sortButton.configuration?.attributedTitle = nil
        }, completion: nil)
    }

    private func setFilterButtonToIconOnly() {
        UIView.transition(with: filterButton, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            guard let self = self else { return }
            self.filterButton.configuration?.attributedTitle = nil
        }, completion: nil)
    }

    private func setSortButtonToFullTitle() {
        UIView.transition(with: sortButton, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            guard let self = self else { return }
            self.setSortButtonTitle(Strings.Filter.sort.localized)
        }, completion: nil)
    }

    private func setFilterButtonToFullTitle() {
        UIView.transition(with: filterButton, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
            guard let self = self else { return }
            self.setFilterButtonTitle(Strings.Filter.sort.localized)
        }, completion: nil)
    }


    
}

extension FilterView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let arguments = viewModel.cellForItem(at: indexPath) else {
            return UICollectionViewCell()
        }
        
        let cell: FilterHeaderCell = collectionView.dequeueReusableCell(for: indexPath)
        let presenter = FilterHeaderCellPresenter(view: cell, arguments: arguments)
        cell.presenter = presenter
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let arguments = viewModel.cellForItem(at: indexPath) else {
            return CGSize(width: 0, height: 0)
        }
        let width = arguments.title.nsString.width(usingFont: UIFont.systemFont(ofSize: 14))
        return CGSize(width: width + 30, height: headerContainer.frame.height * 0.6)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > 100 {
            updateButtonsVisibility(isVisible: true)
        } else {
            updateButtonsVisibility(isVisible: false)
        }
    }
    
}
