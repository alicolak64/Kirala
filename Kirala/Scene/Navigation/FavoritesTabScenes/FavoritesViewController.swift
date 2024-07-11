//
//  FavoritesViewController.swift
//  Kirala
//
//  Created by Ali Çolak on 14.06.2024.
//

import UIKit

final class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: FavoritesViewModel
    
    // MARK: - UI Properties
    
    private lazy var emptyCardView: EmptyStateView = {
        let view = EmptyStateView()
        view.delegate = self
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.makeHeaderStyle()
        view.backgroundColor = ColorBackground.secondary.dynamicColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchBarView = searchBar
    
    private lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ColorBackground.secondary.dynamicColor
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = ColorPalette.appPrimary.dynamicColor
        return refreshControl
    }()
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        gesture.cancelsTouchesInView = false
        return gesture
    }()
    
    // MARK: - Initializers
    init(viewModel: FavoritesViewModel) {
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
        dismissKeyboard()
        viewModel.viewDidDisappear()
    }
    
    // MARK: - Actions
    
    @objc private func refreshControlPulled() {
        viewModel.refresh()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension FavoritesViewController: FavoritesViewProtocol {
    
    func prepareNavigationBar() {
        navigationItem.hidesBackButton = true
        addBottomBorder()
        navigationItem.title = Strings.TabBar.favorites.localized
    }
        
    func prepareUI() {
        view.backgroundColor = ColorBackground.secondary.dynamicColor
        view.addSubviews([
            emptyCardView,
            loadingView
        ])
    }
    
    func prepareConstraints() {
        NSLayoutConstraint.activate([
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emptyCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIDevice.deviceHeight * 0.2),
            emptyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emptyCardView.heightAnchor.constraint(equalToConstant: UIDevice.deviceHeight * 0.3)
        ])
    }
    
    func prepareCollectionView() {
        
        headerView.addSubviews([
            searchBarView
        ])
        
        view.addSubviews([
            headerView,
            productsCollectionView
        ])
                
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.placeholder = Strings.Ad.searchBarPlaceholder.localized
        searchBarView.searchTextField.font = .systemFont(ofSize: 14)
        
        emptyCardView.isHidden = true
        
        view.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50),
            
            
            searchBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBarView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            searchBarView.heightAnchor.constraint(equalToConstant: 40),
            
            productsCollectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 10),
            productsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            productsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            productsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        
        searchBar.isHidden = false
        productsCollectionView.isHidden = false
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(FavoriteCell.self)
        
    }
    
    func showEmptyState(with state: EmptyState) {
        productsCollectionView.isHidden = true
        searchBarView.isHidden = true
        emptyCardView.configure(with: state)
        emptyCardView.show()
    }
        
    func reloadTableView() {
        productsCollectionView.isHidden = false
        searchBarView.isHidden = false
        productsCollectionView.reloadData()
    }
    
    func reloadRows(at indexPaths: [IndexPath]) {
        productsCollectionView.reloadItems(at: indexPaths)
    }
    
    func deleteRows(at indexPaths: [IndexPath]) {
        productsCollectionView.deleteItems(at: indexPaths)
    }
    
    func showLoading() {
        loadingView.showLoading()
    }
    
    func hideLoading(loadResult: LoadingResult) {
        loadingView.hideLoading(loadResult: loadResult)
    }
    
    func addRefreshControl() {
        productsCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
        productsCollectionView.addSubview(refreshControl)
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
        
}


extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(in: section)
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let arguments = viewModel.cellForItem(at: indexPath) else {
            return UICollectionViewCell()
        }
        
        let cell: FavoriteCell = collectionView.dequeueReusableCell(for: indexPath)
        let presenter = FavoriteCellPresenter(view: cell, arguments: arguments)
        presenter.delegate = self
        cell.presenter = presenter
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        viewModel.sizeForItem(at: indexPath, frame: collectionView.frame.size)
    }
    
}

extension FavoritesViewController: EmptyStateViewDelegate {
    

    func didTapActionButton() {
        viewModel.didTapEmptyStateActionButton()
    }
    
}

extension FavoritesViewController: Searchable {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchTextDidChange(searchText)
    }
}

extension FavoritesViewController: FavoriteCellDelegate {
    
    
    func didTapDeleteButton(with id: String) {
        viewModel.didTapDeleteButton(with: id)
    }
    
}

