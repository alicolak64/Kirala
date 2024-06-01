//
//  CategoriesViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import Foundation

struct Subcategory {
    let categoryId: String
    let name: String
    let imageUrl: String
    
    static let mockSubcategories = [
        Subcategory(categoryId: "1", name: "Sweatshirt", imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/022/206/206/small/black-sweatshirt-isolated-cut-out-png.png"),
        Subcategory(categoryId: "1", name: "Ev Aletleri", imageUrl: "https://kuvings.com.tr/wp-content/uploads/her-evde-olmasi-gereken-kucuk-ev-aletleri-listesi.jpg"),
        Subcategory(categoryId: "1", name: "Kozmetik", imageUrl: "https://www.tahtakaletoptanticaret.com/image/cache/catalog/product/24242406498/Kozmetik-Malzeme-Duzenleyici---Glam-Caddy-resim-292-800x800.jpg"),
        Subcategory(categoryId: "1", name: "İç Giyim", imageUrl: "https://www.cdnaws.com/i/720167/QvGYHLnFzROHVUkzZW3D2LnFzROHVUkzZW3D2/urunler/6596d4ece557c-90896-0.jpg"),
        Subcategory(categoryId: "1", name: "Sneakers", imageUrl: "https://static.vecteezy.com/system/resources/previews/019/053/787/original/sneakers-shoes-drawing-png.png")
    ]
    
}

final class CategoriesViewModel {
    
    // MARK: - Dependency Properties
    
    weak var delegate: CategoriesViewProtocol?
    
    private let router: CategoriesRouterProtocol
    
    private var categories : [Category] = Category.mockCategories
    
    private var subCategories : [Subcategory] = Subcategory.mockSubcategories
    
    private var selectedCategoryIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    
    
    // MARK: - Initializers
    
    init(router: CategoriesRouterProtocol) {
        self.router = router
    }
    
}

extension CategoriesViewModel: CategoriesViewModelProtocol {
    
    // MARK: - Lifecycle Methods
    
    func viewDidLoad() {
        delegate?.prepareNavigationBar()
        delegate?.prepareUI()
        delegate?.prepareCategoriesCollectionView()
        delegate?.prepareSubCategoriesCollectionView()
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
    
    // MARK: - Actions
    
    func didTapCancelButton() {
        router.navigate(to: .back)
    }
    
    func didTapSearchButton() {
        router.navigate(to: .search(.noneSearch))
    }
    
    func numberOfItems(in type: CategoriesCollectionViewTag) -> Int {
        switch type {
        case .categories:
            return categories.count
        case .subCategories:
            return subCategories.count
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
            categories[selectedCategoryIndexPath.row].selectionState = .unselected
            categories[indexPath.row].selectionState = .selected
            delegate?.reloadItems(type: .categories, at: [selectedCategoryIndexPath,indexPath])
            selectedCategoryIndexPath = indexPath
        case .subCategories:
            router.navigate(to: .search(.categorySearch(CategorySearchArguments(id: "0", name: subCategories[indexPath.row].name))))
        }
    }
    
    private func cellForItemCategory(at indexPath: IndexPath) -> CategoryCellArguments? {
        let category = categories[indexPath.row]
        return CategoryCellArguments(name: category.name, selectionState: category.selectionState)
    }
    
    private func cellForItemSubCategory(at indexPath: IndexPath) -> SubcategoryCellArguments? {
        let subCategory = subCategories[indexPath.row]
        return SubcategoryCellArguments(name: subCategory.name, imageURL: subCategory.imageUrl)
    }
    
}
