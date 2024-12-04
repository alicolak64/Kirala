//
//  SearchViewController.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

final class SearchViewController: UIViewController, SwipePerformable, BackNavigatable {
    
    // MARK: - Properties
    private let viewModel: SearchViewModel
    
    // MARK: - UI Properties
    
    private lazy var searchBarView = searchBar

    private lazy var emptyCardView: EmptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cancelNavigationButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Strings.Common.cancel.localized, style: .plain, target: self, action: #selector(didTapCancelButton))
        button.tintColor = ColorPalette.appPrimary.dynamicColor
        return button
    }()
    
    private lazy var filterView: FilterView = {
        let viewModel = FilterViewModel()
        let view = FilterView(viewModel: viewModel)
        viewModel.delegate = self
        viewModel.view = view
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var produstsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ColorBackground.secondary.dynamicColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        return collectionView
    }()
    
    private lazy var produstsCollectionViewActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.color = ColorPalette.appPrimary.dynamicColor
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Initializers
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.viewDidLayoutSubviews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    // MARK: - Actions
    
    @objc private func didTapCancelButton() {
        viewModel.didTapCancelButton()
    }
    
    @objc private func didTapView() {
        viewModel.didTapView()
    }
    
    func backButtonTapped() {
        viewModel.didTapCancelButton()
    }
    
}

extension SearchViewController: SearchViewProtocol {
    
    func prepareNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.titleView = searchBarView
    }
    
    func prepareNavigationBarHeaderSearch(with text: String) {
        navigationItem.hidesBackButton = true
        navigationItem.title = text
        addBottomBorder()
    }
    
    func prepareBackNavigation(type: BackButtonViewLocation) {
        switch type {
        case .left:
            addBackButton()
        case .right:
            navigationItem.rightBarButtonItem = cancelNavigationButton
        }
    }
    
    func prepareUI() {
        view.backgroundColor = ColorBackground.primary.dynamicColor
        view.addSubviews([
            emptyCardView,
            loadingView,
            filterView,
            produstsCollectionView,
            produstsCollectionViewActivityIndicator
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
            
            filterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            filterView.heightAnchor.constraint(equalToConstant: 50),
            
            
            
            produstsCollectionView.topAnchor.constraint(equalTo: filterView.bottomAnchor),
            produstsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            produstsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            produstsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            produstsCollectionViewActivityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            produstsCollectionViewActivityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
            
        ])

        
    }
    
    func prepareProductsCollectionView() {
        produstsCollectionView.delegate = self
        produstsCollectionView.dataSource = self
        produstsCollectionView.register(SearchProductCell.self)
    }
    
    func showProductsCollectionView() {
        produstsCollectionView.isHidden = false
    }
    
    func showFilterView() {
        filterView.isHidden = false
    }
    
    func showLoading() {
        loadingView.showLoading()
    }
    
    func hideLoading(loadResult: LoadingResult) {
        loadingView.hideLoading(loadResult: loadResult)
    }
    
    func showPaginationLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.produstsCollectionViewActivityIndicator.isHidden = false
            self.produstsCollectionViewActivityIndicator.startAnimating()
        }
    }
    
    func hidePaginationLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.produstsCollectionViewActivityIndicator.isHidden = true
            self.produstsCollectionViewActivityIndicator.stopAnimating()
        }
    }
    
    func openSearchBar() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.searchBarView.becomeFirstResponder()
        }
    }
    
    func openSearchBar(with query: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.searchBarView.text = query
            self?.searchBarView.becomeFirstResponder()
        }
    }
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        view.addGestureRecognizer(tap)
    }
    
    func addSwipeGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(didTapCancelButton))
        gesture.direction = .right
        view.addGestureRecognizer(gesture)
    }
    
    func setSearchBarPlaceHolder(with placeholder: String) {
        DispatchQueue.main.async { [weak self] in
            self?.searchBarView.placeholder = placeholder
        }
    }
    
    func closeSearchBar() {
        searchBarView.resignFirstResponder()
    }
    
    func showEmptyState(with state: EmptyState) {
        emptyCardView.configure(with: state)
        emptyCardView.show()
    }
    
    func reloadRows(at indexPaths: [IndexPath]) {
        produstsCollectionView.reloadItems(at: indexPaths)
    }
    
    func reloadCollectionView() {
        produstsCollectionView.reloadData()
    }
    
    func insertItems(at indexPaths: [IndexPath]) {
        produstsCollectionView.performBatchUpdates {
            produstsCollectionView.insertItems(at: indexPaths)
        } completion: { _ in
            
        }
    }
    
    func reloadFavoriteState(indexPath: IndexPath, favoriteState: FavoriteState) {
        if let cell = produstsCollectionView.cellForItem(at: indexPath) as? SearchProductCell {
            cell.presenter.updateFavoriteIcon(state: favoriteState)
        }
    }
    
    func addBadgeCountFilterView(count: Int) {
        filterView.setBadgeCount(count)
    }
    
    func removeBadgeCountFilterView() {
        filterView.removeBadge()
    }

    
}

extension SearchViewController: UISearchBarDelegate, Searchable {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        viewModel.searchBarShouldBeginEditing()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchBarSearchButtonClicked(with: searchBar.text)
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        
        let cell: SearchProductCell = collectionView.dequeueReusableCell(for: indexPath)
        let presenter = SearchProductCellPresenter(view: cell, arguments: arguments)
        presenter.delegate = self
        cell.presenter = presenter
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.sizeForItem(at: indexPath, frame: collectionView.frame.size)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewModel.scrollViewDidScroll(contentOffset: scrollView.contentOffset, contentSize: scrollView.contentSize, bounds: scrollView.bounds)
    }
    
}

extension SearchViewController: SearchProductCellDelegate {
    
    func didTapFavoriteButton(at indexPath: IndexPath) {
        viewModel.didTapFavoriteButton(at: indexPath)
    }
    
    func didTapImageSliderView(at indexPath: IndexPath) {
        viewModel.didTapImageSliderView(at: indexPath)
    }
    
}

extension SearchViewController: FilterViewDelegate {
    
    func didTapSortButton() {
        viewModel.didTapSortButton()
    }
    
    func didTapFilterButton() {
        viewModel.didTapFilterButton()
    }
    
    func numberOfItems(in section: Int) -> Int {
        viewModel.numberOfFilters(in: section)
    }
    
    func cellForItem(at indexPath: IndexPath) -> FilterViewModelArguments? {
        viewModel.cellForFilterItem(at: indexPath)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        viewModel.didSelectFilterItem(at: indexPath)
    }
    
    func closeExpandedCell(type: FilterType) {
        filterView.closeExpandedCell(type: type)
    }
    
    func reloadFilterCell(type: FilterType) {
        filterView.reloadFilterCell(type: type)
    }
    
}

extension SearchViewController: ActionSheetable {
    
}





