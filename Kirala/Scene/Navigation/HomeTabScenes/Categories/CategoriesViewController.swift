//
//  CategoriesViewController.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import UIKit

final class CategoriesViewController: UIViewController, SwipePerformable, BackNavigatable {    
    
    // MARK: - Properties
    private let viewModel: CategoriesViewModel
    
    // MARK: - UI Properties
    
    private lazy var searchBarView = searchBar
    
    private lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width * 0.25, height: 45)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ColorBackground.secondary.dynamicColor
        collectionView.tag = CategoriesCollectionViewTag.categories.rawValue
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var subCategoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width * 0.15, height: 120)
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = ColorBackground.primary.dynamicColor
        collectionView.tag = CategoriesCollectionViewTag.subCategories.rawValue
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Initializers
    init(viewModel: CategoriesViewModel) {
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
        
    func backButtonTapped() {
        viewModel.didTapCancelButton()
    }
    
    // MARK: - Helpers
    
    private func getCollectionViewType(with tag: Int) -> CategoriesCollectionViewTag {
        return CategoriesCollectionViewTag(rawValue: tag) ?? .categories
    }
    
}

extension CategoriesViewController: CategoriesViewProtocol {
    
    func prepareNavigationBar() {
        navigationItem.hidesBackButton = true
        addBackButton()
        addBottomBorder()
        navigationItem.titleView = searchBarView
    }
    
    func prepareUI() {
        view.backgroundColor = ColorBackground.primary.dynamicColor
        view.addSubviews([
            categoriesCollectionView,
            subCategoriesCollectionView,
        ])
    }
    
    func prepareConstraints() {
        NSLayoutConstraint.activate([
            
            categoriesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            categoriesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            categoriesCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            
            subCategoriesCollectionView.topAnchor.constraint(equalTo: categoriesCollectionView.topAnchor),
            subCategoriesCollectionView.leadingAnchor.constraint(equalTo: categoriesCollectionView.trailingAnchor),
            subCategoriesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            subCategoriesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    func prepareCategoriesCollectionView() {
        categoriesCollectionView.register(CategoryCell.self)
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
    }
    
    func prepareSubCategoriesCollectionView() {
        subCategoriesCollectionView.register(SubcategoryCell.self)
        subCategoriesCollectionView.delegate = self
        subCategoriesCollectionView.dataSource = self
    }
    
    func reloadData(type: CategoriesCollectionViewTag) {
        switch type {
        case .categories:
            categoriesCollectionView.reloadData()
        case .subCategories:
            subCategoriesCollectionView.reloadData()
        }
    }
    
    func reloadItems(type: CategoriesCollectionViewTag, at indexPaths: [IndexPath]) {
        switch type {
        case .categories:
            categoriesCollectionView.reloadItems(at: indexPaths)
        case .subCategories:
            subCategoriesCollectionView.reloadItems(at: indexPaths)
        }
    }
    
    
    
}

extension CategoriesViewController: UISearchBarDelegate, Searchable {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        viewModel.didTapSearchButton()
        return false
    }
    
}

extension CategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: getCollectionViewType(with: collectionView.tag))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let type = getCollectionViewType(with: collectionView.tag)
        guard let arguments = viewModel.cellForItem(in: type, at: indexPath) else {
            return UICollectionViewCell()
        }
        
        switch type {
        case .categories:
            let cell: CategoryCell = collectionView.dequeueReusableCell(for: indexPath)
            let presenter = CategoryCellPresenter(view: cell, arguments: arguments as! CategoryCellArguments, type: .search)
            presenter.load()
            return cell
        case .subCategories:
            let arguments = viewModel.cellForItem(in : getCollectionViewType(with: collectionView.tag), at: indexPath)
            let cell: SubcategoryCell = collectionView.dequeueReusableCell(for: indexPath)
            let presenter = SubcategoryCellPresenter(view: cell, arguments: arguments as! SubcategoryCellArguments)
            presenter.load()
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(in: getCollectionViewType(with: collectionView.tag), at: indexPath)
    }
    
}

