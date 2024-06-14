//
//  HomeViewController.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Dependency Properties
    
    private let viewModel: HomeViewModel
    private let layoutGenerator: HomeCollectionViewLayoutsGenerator
    
    // MARK: - UI Properties
    
    private lazy var notificationNavigationButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.layer.cornerRadius = 15
        button.backgroundColor = ColorPalette.appSecondary.dynamicColor
        
        let icon = Symbols.bellBadge.symbol()
        button.tintColor = ColorText.white.dynamicColor
        button.setImage(icon, for: .normal)
        
        button.addTarget(self, action: #selector(didTapNotificationButton), for: .touchUpInside)
        
        let favoriteButtonItem = UIBarButtonItem(customView: button)
        
        return favoriteButtonItem
    }()
    
    private lazy var searchBarView = searchBar
    
    private lazy var emptyCardView: EmptyStateView = {
        let view = EmptyStateView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = ColorPalette.appPrimary.dynamicColor
        return refreshControl
    }()
    
    private lazy var contentCompositinalLayoutCollectionViewFooterActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = ColorPalette.appPrimary.dynamicColor
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private lazy var categoriesContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorBackground.primary.dynamicColor
        return view
    }()
        
    private lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ColorBackground.primary.dynamicColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.tag = HomeCollectionViewTag.categories.rawValue
        return collectionView
    }()
    
    
    private lazy var contentCompositinalLayoutCollectionView : UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = ColorBackground.secondary.dynamicColor
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.tag = HomeCollectionViewTag.compositionalLayout.rawValue
        return collectionView
    }()
    
    // MARK: - Initializers
    
    init(viewModel: HomeViewModel, layoutGenerator: HomeCollectionViewLayoutsGenerator) {
        self.viewModel = viewModel
        self.layoutGenerator = layoutGenerator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        layoutGenerator.delegate = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.viewDidLayoutSubviews()
    }
    
    // MARK: - Actions
    
    @objc private func didTapNotificationButton() {
        viewModel.didTapNotificationButton()
    }
    
    @objc private func refreshControlPulled() {
        viewModel.refresh()
    }
        
    // MARK: - Helper Methods
    
    private func getTypeCollectionView(with tag: Int) -> HomeCollectionViewTag {
        return HomeCollectionViewTag(rawValue: tag) ?? .categories
    }
    
    private func getTypeCompositionalLayout(with section: Int) -> HomeCompositionalLayoutSection {
        return HomeCompositionalLayoutSection(rawValue: section) ?? .campaign
    }
    
}

extension HomeViewController: HomeViewProtocol {
    

    func prepareNavigationBar() {
        navigationItem.titleView = searchBarView
        navigationItem.rightBarButtonItem = notificationNavigationButton
    }
    
    func prepareUI() {
        view.backgroundColor = ColorBackground.primary.dynamicColor
        
        view.addSubviews([
            emptyCardView,
            loadingView,
        ])
        
    }
    
    func prepareConstraints() {
        NSLayoutConstraint.activate([
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emptyCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIDevice.deviceHeight * 0.2),
            emptyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emptyCardView.heightAnchor.constraint(equalToConstant: UIDevice.deviceHeight * 0.3),
                    
            
        ])
    }
    
    func prepareCategoriesCollectionView() {
        
        categoriesContainer.addSubviews([
            categoriesCollectionView
        ])
        
        view.addSubview(categoriesContainer)
        
        NSLayoutConstraint.activate([
            categoriesContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoriesContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesContainer.heightAnchor.constraint(equalToConstant: UIDevice.deviceHeight * 0.06),
            categoriesContainer.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            categoriesCollectionView.topAnchor.constraint(equalTo: categoriesContainer.topAnchor, constant: 5),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: categoriesContainer.leadingAnchor, constant: 15),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: categoriesContainer.trailingAnchor),
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: UIDevice.deviceHeight * 0.045),

        ])
        
        categoriesCollectionView.register(CategoryCell.self)
        categoriesCollectionView.registerHeader(CategoriesHeaderView.self)
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
    }
    
    func prepareContentCompositinalLayoutCollectionView() {
        
        view.addSubviews([
            contentCompositinalLayoutCollectionView,
            contentCompositinalLayoutCollectionViewFooterActivityIndicator
        ])
        
        NSLayoutConstraint.activate([
            contentCompositinalLayoutCollectionView.topAnchor.constraint(equalTo: categoriesContainer.bottomAnchor),
            contentCompositinalLayoutCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentCompositinalLayoutCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentCompositinalLayoutCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentCompositinalLayoutCollectionViewFooterActivityIndicator.centerXAnchor.constraint(equalTo: contentCompositinalLayoutCollectionView.centerXAnchor),
            contentCompositinalLayoutCollectionViewFooterActivityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        contentCompositinalLayoutCollectionView.register(CampaignCell.self)
        contentCompositinalLayoutCollectionView.register(ProductCell.self)
        contentCompositinalLayoutCollectionView.registerHeader(ProductsHeaderCell.self)
        contentCompositinalLayoutCollectionView.delegate = self
        contentCompositinalLayoutCollectionView.dataSource = self
    }
    
    func configureContentCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex,enviroment in
            
            guard let self = self, let section = HomeCompositionalLayoutSection(rawValue: sectionIndex) else { return nil }
            
            switch section {
            case .campaign:
                return self.layoutGenerator.getLayout(type: .campaign)
            case .newAdded:
                return self.layoutGenerator.getLayout(type: .newAdded)
            case .bestSellers:
                return self.layoutGenerator.getLayout(type: .bestSellers)
            case .mostRated:
                return self.layoutGenerator.getLayout(type: .mostRated)
            case .allProducts:
                return self.layoutGenerator.getLayout(type: .allProducts)
            }
            
        }
        contentCompositinalLayoutCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    func reloadRows(type: HomeCollectionViewTag, at indexPaths: [IndexPath]) {
        switch type {
        case .categories:
            categoriesCollectionView.reloadItems(at: indexPaths)
        case .compositionalLayout:
            guard let firstIndexPath = indexPaths.first else { return }
            let section = firstIndexPath.section
            
            switch getTypeCompositionalLayout(with: section) {
            case .campaign:
                contentCompositinalLayoutCollectionView.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: true)
            case .newAdded:
                contentCompositinalLayoutCollectionView.reloadItems(at: indexPaths)
            case .bestSellers:
                contentCompositinalLayoutCollectionView.reloadItems(at: indexPaths)
            case .mostRated:
                contentCompositinalLayoutCollectionView.reloadItems(at: indexPaths)
            case .allProducts:
                contentCompositinalLayoutCollectionView.reloadItems(at: indexPaths)
            }
            
        }
    }
    
    func reloadFavoriteState(indexPath: IndexPath, favoriteState: FavoriteState) {
        if let cell = contentCompositinalLayoutCollectionView.cellForItem(at: indexPath) as? ProductCell {
            cell.presenter.updateFavoriteIcon(state: favoriteState)
        }
    }
    
    func reloadCollectionView(type: HomeCollectionViewTag) {
        switch type {
        case .categories:
            categoriesCollectionView.reloadData()
        case .compositionalLayout:
            contentCompositinalLayoutCollectionView.reloadData()
        }
        
    }
    
    func reloadSections(type: HomeCollectionViewTag, at indexSet: IndexSet) {
        switch type {
        case .categories:
            categoriesCollectionView.reloadSections(indexSet)
        case .compositionalLayout:
            contentCompositinalLayoutCollectionView.reloadSections(indexSet)
        }
    }
    
    func didScrollToItem(at indexPath: IndexPath) {
        viewModel.didScrollToItem(at: indexPath)
    }
    
    func showEmptyState(with state: EmptyState) {
        emptyCardView.configure(with: state)
        emptyCardView.show()
    }
    
    func showLoading() {
        loadingView.showLoading()
    }
    
    func hideLoading(loadResult: LoadingResult) {
        loadingView.hideLoading(loadResult: loadResult)
    }
    
    func showContentCompositionalLayoutLoading() {
        contentCompositinalLayoutCollectionViewFooterActivityIndicator.isHidden = false
        contentCompositinalLayoutCollectionViewFooterActivityIndicator.startAnimating()
    }
    
    func hideContentCompositionalLayoutLoading() {
        contentCompositinalLayoutCollectionViewFooterActivityIndicator.isHidden = true
        contentCompositinalLayoutCollectionViewFooterActivityIndicator.stopAnimating()
    }
    
    func addRefreshControl() {
        contentCompositinalLayoutCollectionView.refreshControl = refreshControl
        contentCompositinalLayoutCollectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
}

extension HomeViewController: UISearchBarDelegate, Searchable {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        viewModel.didTapSearchButton()
        return false
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections(type: getTypeCollectionView(with: collectionView.tag))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection(type: getTypeCollectionView(with: collectionView.tag), section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = getTypeCollectionView(with: collectionView.tag)
        guard let arguments = viewModel.cellForItem(type: type, at: indexPath) else {
            return UICollectionViewCell()
        }
        
        switch type {
        case .categories:
            let cell: CategoryCell = collectionView.dequeueReusableCell(for: indexPath)
            let presenter = CategoryCellPresenter(view: cell, arguments: arguments as! CategoryCellArguments, type: .home)
            cell.presenter = presenter
            return cell
        case .compositionalLayout:
            
            let section = HomeCompositionalLayoutSection(rawValue: indexPath.section) ?? .campaign
            
            switch section {
            case .campaign:
                let cell: CampaignCell = collectionView.dequeueReusableCell(for: indexPath)
                let presenter = CampaignCellPresenter(view: cell, arguments: arguments as! CampaignCellArguments)
                cell.presenter = presenter
                return cell
            case .newAdded:
                let cell: ProductCell = collectionView.dequeueReusableCell(for: indexPath)
                let presenter = ProductCellPresenter(view: cell, arguments: arguments as! ProductCellArguments)
                presenter.delegate = self
                cell.presenter = presenter
                return cell
            case .bestSellers:
                let cell: ProductCell = collectionView.dequeueReusableCell(for: indexPath)
                let presenter = ProductCellPresenter(view: cell, arguments: arguments as! ProductCellArguments)
                presenter.delegate = self
                cell.presenter = presenter
                return cell
            case .mostRated:
                let cell: ProductCell = collectionView.dequeueReusableCell(for: indexPath)
                let presenter = ProductCellPresenter(view: cell, arguments: arguments as! ProductCellArguments)
                presenter.delegate = self
                cell.presenter = presenter
                return cell
            case .allProducts:
                let cell: ProductCell = collectionView.dequeueReusableCell(for: indexPath)
                let presenter = ProductCellPresenter(view: cell, arguments: arguments as! ProductCellArguments)
                presenter.delegate = self
                cell.presenter = presenter
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(type: getTypeCollectionView(with: collectionView.tag), at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let type = getTypeCollectionView(with: collectionView.tag)
        switch type {
        case .categories:
            guard let arguments = viewModel.cellForItem(type: type, at: indexPath) as? CategoryCellArguments else {
                return CGSize(width: 0, height: 0)
            }
            let width = arguments.name.nsString.width(usingFont: UIFont.systemFont(ofSize: 14))
            return CGSize(width: width + 20, height: UIDevice.deviceHeight * 0.035)
        case .compositionalLayout:
            return CGSize(width: contentCompositinalLayoutCollectionView.frame.width, height: contentCompositinalLayoutCollectionView.frame.height)
        }
        
    }
    
    // Header View Ayarları
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        viewModel.sizeForHeader(type: getTypeCollectionView(with: collectionView.tag), section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            fatalError("Unexpected element kind")
        }
        
        let type = getTypeCollectionView(with: collectionView.tag)
        let arguments = viewModel.headerForSection(type: type, section: indexPath.section)
        
        switch type {
        case .categories:
            let cell: CategoriesHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            let presenter = CategoriesHeaderViewPresenter(view: cell, arguments: arguments as! CategoriesHeaderArguments )
            presenter.delegate = self
            cell.presenter = presenter
            return cell
        case .compositionalLayout:
            
            let section = HomeCompositionalLayoutSection(rawValue: indexPath.section) ?? .campaign
            
            switch section {
            case .campaign:
                return UICollectionReusableView()
            case .newAdded:
                let cell: ProductsHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
                let presenter = ProductsHeaderCellPresenter(view: cell, arguments: arguments as! ProductsHeaderArguments )
                presenter.delegate = self
                cell.presenter = presenter
                return cell
            case .bestSellers:
                let cell: ProductsHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
                let presenter = ProductsHeaderCellPresenter(view: cell, arguments: arguments as! ProductsHeaderArguments )
                presenter.delegate = self
                cell.presenter = presenter
                return cell
            case .mostRated:
                let cell: ProductsHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
                let presenter = ProductsHeaderCellPresenter(view: cell, arguments: arguments as! ProductsHeaderArguments )
                presenter.delegate = self
                cell.presenter = presenter
                return cell
            case .allProducts:
                let cell: ProductsHeaderCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
                let presenter = ProductsHeaderCellPresenter(view: cell, arguments: arguments as! ProductsHeaderArguments )
                presenter.delegate = self
                cell.presenter = presenter
                return cell
            }
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == contentCompositinalLayoutCollectionView else { return }
        viewModel.scrollViewDidScroll(contentOffset: scrollView.contentOffset, contentSize: scrollView.contentSize, bounds: scrollView.bounds)
    }

}

extension HomeViewController: CategoriesHeaderDelegate {
    
    func didTapAllCategories() {
        viewModel.didTapAllCategoriesButton()
    }
}

extension HomeViewController: ProductsHeaderCellDelegate {
    func didTapAllProducts(headerType: HeaderType) {
        viewModel.didTapAllProductsButton(headerType: headerType)
    }
}

extension HomeViewController: ProductCellDelegate {
    func didTapFavoriteButton(at indexPath: IndexPath) {
        viewModel.didTapFavoriteButton(at: indexPath)
    }
}

extension HomeViewController: ActionSheetable {
    
}

extension HomeViewController: EmptyStateViewDelegate {
    
    func didTapActionButton() {
        viewModel.didTapEmptyStateActionButton()
    }
    
}


