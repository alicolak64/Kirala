//
//  FilterPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 30.05.2024.
//

import Foundation

struct FilterViewModelArguments: Equatable {
    let title: String
    let type: FilterType
    let isAvaliableSelectedItems: Bool
}

struct FilterHeaderItem: Expandable {
    let title: String
    let type: FilterType
    let isAvaliableSelectedItems: Bool
    var expandedState: ExpandState
}

protocol FilterViewModelProtocol {
    var delegate: FilterViewDelegate? { get set }
    var view: FilterViewProtocol? { get set }
    func didTapSortButton()
    func didTapFilterButton()
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func cellForItem(at indexPath: IndexPath) -> FilterHeaderCellArguments?
    func didSelectItem(at indexPath: IndexPath)
    func closeExpandedCell(type: FilterType)
    func reloadFilterCell(type: FilterType)
}



final class FilterViewModel: FilterViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: FilterViewDelegate?
    weak var view: FilterViewProtocol?
    private var items: [FilterType: FilterHeaderItem] = [:]
    
    // MARK: - Init
    
    init() {
        
    }
        
    // MARK: - FilterPresenterProtocol
    
    func didTapSortButton() {
        delegate?.didTapSortButton()
    }
    
    func didTapFilterButton() {
        delegate?.didTapFilterButton()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems(in section: Int) -> Int {
        delegate?.numberOfItems(in: section) ?? 0
    }
    
    func cellForItem(at indexPath: IndexPath) -> FilterHeaderCellArguments? {
        let item = delegate?.cellForItem(at: indexPath)
        guard 
            let title = item?.title,
            let type = item?.type,
            let isAvaliableSelectedItems = item?.isAvaliableSelectedItems
        else { return nil }
        let expandState = items[type]?.expandedState ?? .collapsed
        items[type] = FilterHeaderItem(title: title, type: type, isAvaliableSelectedItems: isAvaliableSelectedItems, expandedState: expandState)
        return FilterHeaderCellArguments(title: title, isAvaliableSelectedItems: isAvaliableSelectedItems, expandedState: expandState)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        guard let item = delegate?.cellForItem(at: indexPath) else { return }
        items[item.type]?.expandedState.toggle()
        view?.reloadExpandState(indexPath: indexPath, expandState: items[item.type]?.expandedState ?? .collapsed)
        delegate?.didSelectItem(at: indexPath)
    }
    
    func closeExpandedCell(type: FilterType) {
        items[type]?.expandedState = .collapsed
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak view] in
            view?.reloadExpandState(indexPath: IndexPath(row: type.rawValue, section: 0), expandState: .collapsed)
        }
    }

    
    func reloadFilterCell(type: FilterType) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak view] in
            view?.reloadItems(at: [IndexPath(row: type.rawValue, section: 0)])
        }
    }
    
}

protocol FilterViewDelegate: AnyObject {
    func didTapSortButton()
    func didTapFilterButton()
    func numberOfItems(in section: Int) -> Int
    func cellForItem(at indexPath: IndexPath) -> FilterViewModelArguments?
    func didSelectItem(at indexPath: IndexPath)
}

protocol FilterViewProtocol: AnyObject {
    func setSortButtonTitle(_ title: String)
    func setFilterButtonTitle(_ title: String)
    func setBadgeCount(_ count: Int)
    func removeBadge()
    func reloadCollectionView()
    func reloadItems(at indexPaths: [IndexPath])
    func reloadExpandState(indexPath: IndexPath, expandState: ExpandState)
    func closeExpandedCell(type: FilterType)
    func reloadFilterCell(type: FilterType)
}

