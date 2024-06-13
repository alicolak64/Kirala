//
//  CategoriesViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import Foundation

struct CategoryWithSubcategory: Selectable {
    let id: String
    let name: String
    var selectionState: SelectionState = .unselected
    let subcategories: [SubcategoryWithImageResponse]
}

struct Subcategory {
    let id: String
    let name: String
    let imageUrl: String
    
    static let mockSubcategories = [
        Subcategory(id: "1", name: "Sweatshirt", imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/022/206/206/small/black-sweatshirt-isolated-cut-out-png.png"),
        Subcategory(id: "1", name: "Ev Aletleri", imageUrl: "https://kuvings.com.tr/wp-content/uploads/her-evde-olmasi-gereken-kucuk-ev-aletleri-listesi.jpg"),
        Subcategory(id: "1", name: "Kozmetik", imageUrl: "https://www.tahtakaletoptanticaret.com/image/cache/catalog/product/24242406498/Kozmetik-Malzeme-Duzenleyici---Glam-Caddy-resim-292-800x800.jpg"),
        Subcategory(id: "1", name: "İç Giyim", imageUrl: "https://www.cdnaws.com/i/720167/QvGYHLnFzROHVUkzZW3D2LnFzROHVUkzZW3D2/urunler/6596d4ece557c-90896-0.jpg"),
        Subcategory(id: "1", name: "Sneakers", imageUrl: "https://static.vecteezy.com/system/resources/previews/019/053/787/original/sneakers-shoes-drawing-png.png")
    ]
    
    static let otherWithMockSubcategories = [
        Subcategory(id: "1", name: "Sweatshirt", imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/022/206/206/small/black-sweatshirt-isolated-cut-out-png.png"),
        Subcategory(id: "1", name: "Ev Aletleri", imageUrl: "https://kuvings.com.tr/wp-content/uploads/her-evde-olmasi-gereken-kucuk-ev-aletleri-listesi.jpg"),
        Subcategory(id: "1", name: "Kozmetik", imageUrl: "https://www.tahtakaletoptanticaret.com/image/cache/catalog/product/24242406498/Kozmetik-Malzeme-Duzenleyici---Glam-Caddy-resim-292-800x800.jpg"),
        Subcategory(id: "1", name: "İç Giyim", imageUrl: "https://www.cdnaws.com/i/720167/QvGYHLnFzROHVUkzZW3D2LnFzROHVUkzZW3D2/urunler/6596d4ece557c-90896-0.jpg"),
        Subcategory(id: "1", name: "Sneakers", imageUrl: "https://static.vecteezy.com/system/resources/previews/019/053/787/original/sneakers-shoes-drawing-png.png"),
        Subcategory(id: "0", name: "Other", imageUrl: "https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg")
    ]
    
}

final class CategoriesViewModel {
    
    // MARK: - Dependency Properties
    
    weak var delegate: CategoriesViewProtocol?
    
    private let router: CategoriesRouterProtocol
    private let categoryService: CategoryService
    
    private var categories = [CategoryWithSubcategory]()
    private var selectedCategoryIndex = 0
    
    private var loadingState: LoadingState = .loading {
        didSet {
            switch loadingState {
            case .loading:
                delegate?.showLoading()
            case .loaded(let result):
                self.delegate?.hideLoading(loadResult: result)
            }
        }
    }
    
    
    // MARK: - Initializers
    
    init(router: CategoriesRouterProtocol, dependencies: [Dependency : Any]) {
        guard let categoryService = dependencies[.categoryService] as? CategoryService else {
            fatalError("Category Service could not be resolved.")
        }
        self.router = router
        self.categoryService = categoryService
    }
    
}

extension CategoriesViewModel: CategoriesViewModelProtocol {
    
    // MARK: - Lifecycle Methods
    
    func viewDidLoad() {
        delegate?.prepareNavigationBar()
        delegate?.prepareUI()
        fetchCategories()
    }
    
    func viewWillAppear() {
        //delegate?.showEmptyState()
    }
    
    func viewDidAppear() {
        delegate?.addSwipeGesture()
    }
    
    func viewDidDisappear() {
        delegate?.removeSwipeGesture()
    }
    
    func viewDidLayoutSubviews() {
        delegate?.prepareConstraints()
    }
    
    // MARK: - Network Methods
    
    private func fetchCategories() {
        loadingState = .loading
        categoryService.getCategoryListWithSubcategories { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let categories):
                    guard let categories = categories.data else { return }
                    self.categories = categories.map { CategoryWithSubcategory(id: $0.id, name: $0.name, subcategories: $0.subcategories) }
                    self.categories[0].selectionState = .selected
                    self.selectedCategoryIndex = 0
                    self.loadingState = .loaded(.none)
                    self.delegate?.prepareCategoriesCollectionView()
                    self.delegate?.prepareSubCategoriesCollectionView()
                    self.delegate?.reloadData(type: .categories)
                    self.delegate?.reloadData(type: .subCategories)
                case .failure(let error):
                    self.loadingState = .loaded(.none)
                    self.delegate?.showEmptyState(with: .error(error))
                }
            }
        }
    }
    
    // MARK: - Actions
    
    func didTapCancelButton() {
        router.navigate(to: .back)
    }
    
    func didTapSearchButton() {
        router.navigate(to: .search(.noneSearch))
    }
    
    func didTapEmptyStateActionButton() {
        fetchCategories()
    }
    
    func numberOfItems(in type: CategoriesCollectionViewTag) -> Int {
        switch type {
        case .categories:
            return categories.count
        case .subCategories:
            return categories[selectedCategoryIndex].subcategories.count
        }
    }
    
    func cellForItem(in type: CategoriesCollectionViewTag, at indexPath: IndexPath) -> Any? {
        switch type {
        case .categories:
            return cellForItemCategory(at: indexPath)
        case .subCategories:
            return cellForItemSubCategory(at: indexPath)
        }
    }
    
    func didSelectItem(in type: CategoriesCollectionViewTag, at indexPath: IndexPath) {
        switch type {
        case .categories:
            categories[selectedCategoryIndex].selectionState = .unselected
            categories[indexPath.row].selectionState = .selected
            delegate?.reloadItems(type: .categories, at: [IndexPath(row: selectedCategoryIndex, section: 0), indexPath])
            selectedCategoryIndex = indexPath.row
            delegate?.reloadData(type: .subCategories)
        case .subCategories:
            router.navigate(to: .search(.categorySearch(
                CategorySearchArguments(
                    id: categories[selectedCategoryIndex].subcategories[indexPath.row].id,
                    name: categories[selectedCategoryIndex].subcategories[indexPath.row].name
                )
            )))
        }
    }
    
    private func cellForItemCategory(at indexPath: IndexPath) -> CategoryCellArguments? {
        let category = categories[indexPath.row]
        return CategoryCellArguments(name: category.name, selectionState: category.selectionState)
    }
    
    private func cellForItemSubCategory(at indexPath: IndexPath) -> SubcategoryCellArguments? {
        let subCategory = categories[selectedCategoryIndex].subcategories[indexPath.row]
        if let imageUrl = subCategory.imageUrl {
            return SubcategoryCellArguments(name: subCategory.name, imageURL: imageUrl)
        } else {
            return SubcategoryCellArguments(name: subCategory.name, imageURL: String.noImageURLString)
        }
    }
    
}
