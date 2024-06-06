//
//  FilterPopupPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 30.05.2024.
//

import Foundation

enum FilterType: Int, CaseIterable {
    case category
    case brand
    case city
    case price
    case rating
    case renter
    case rentalPeriod
    
    func convertSearchablePopupType() -> SearchablePopupType {
        switch self {
        case .category:
            return .category
        case .brand:
            return .brand
        case .city:
            return .city
        case .renter:
            return .renter
        default:
            fatalError("SearchablePopupType not found for \(self)")
        }
    }
    
    func convertMinMaxPopupType() -> MinMaxPopupType {
        switch self {
        case .price:
            return .price
        case .rating:
            return .rating
        case .rentalPeriod:
            return .rentalPeriod
        default:
            fatalError("SearchablePopupType not found for \(self)")
        }
    }
}

struct FilterOption {
    let title: String
    let type: FilterType
    var selectedItems: [String]
    static func makeFilterOptions() -> [FilterOption] {
        return FilterType.allCases.map { type in
            switch type {
            case .category:
                return FilterOption(title: Strings.Filter.category.localized, type: type, selectedItems: [])
            case .brand:
                return FilterOption(title: Strings.Filter.brand.localized, type: type, selectedItems: [])
            case .price:
                return FilterOption(title: Strings.Filter.price.localized, type: type, selectedItems: [])
            case .rating:
                return FilterOption(title: Strings.Filter.rating.localized, type: type, selectedItems: [])
            case .renter:
                return FilterOption(title: Strings.Filter.renter.localized, type: type, selectedItems: [])
            case .rentalPeriod:
                return FilterOption(title: Strings.Filter.rentalPeriod.localized, type: type, selectedItems: [])
            case .city:
                return FilterOption(title: Strings.Filter.city.localized, type: type, selectedItems: [])
            }
        }
    }
}

struct FilterPopupArguments {
    let title: String
    let filterOptions: [FilterOption]
}

protocol FilterPopupDelegate: AnyObject {
    func didSelectFilterOption(_ option: FilterType)
    func didTapDismissButton()
    func didTapClearFilterButton()
}

protocol FilterPopupPresenterProtocol {
    var delegate: FilterPopupDelegate? { get set }
    func load()
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> FilterCellArguments?
    func heightForRow(at indexPath: IndexPath) -> CGFloat
    func didSelectRow(at indexPath: IndexPath)
    
    func didTapDismissButton()
    func didTapClearButton()
    func didTapListProductsButton()
    func isSearchableFilterOption(indexPath: IndexPath) -> Bool
}

protocol FilterPopupViewProtocol: AnyObject {
    func setTitle(_ title: String)
    func reloadTableView()
    func reloadRows(at indexPaths: [IndexPath])
}

final class FilterPopupPresenter {
    // MARK: - Properties
    
    weak var delegate: FilterPopupDelegate?
    private weak var view: FilterPopupViewProtocol?
    private let arguments: FilterPopupArguments
    private var selectedItems: [FilterType: [String]] = [:]
    
    // MARK: - Init
    
    init(view: FilterPopupViewProtocol?, arguments: FilterPopupArguments) {
        self.view = view
        self.arguments = arguments
        self.selectedItems = Dictionary(uniqueKeysWithValues: arguments.filterOptions.map { ($0.type, $0.selectedItems) })
    }
    
    deinit {
        removeObserver()
    }
    
    // MARK: - Private Functions
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(searchableFilterOptionsDidChange(_:)), name: .searchableFilterOptionsDidChange, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(minMaxFilterOptionsDidChange(_:)), name: .minMaxFilterOptionsDidChange, object: nil)
    }
 
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: .minMaxFilterOptionsDidChange, object: nil)
    }
    
    @objc private func searchableFilterOptionsDidChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let type = userInfo[NotificationCenterOutputs.type.rawValue] as? FilterType,
              let items = userInfo[NotificationCenterOutputs.items.rawValue] as? [String] else {
            return
        }
        selectedItems[type] = items.map { $0 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak view] in
            view?.reloadRows(at: [IndexPath(row: type.rawValue, section: 0)])
        }
    }
    
    @objc private func minMaxFilterOptionsDidChange(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let type = userInfo[NotificationCenterOutputs.type.rawValue] as? FilterType,
              let items = userInfo[NotificationCenterOutputs.items.rawValue] as? [String] else {
            return
        }
        selectedItems[type] = [items.joined(separator: " ")]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { [weak view] in
            view?.reloadRows(at: [IndexPath(row: type.rawValue, section: 0)])
        }
    }

}

extension FilterPopupPresenter: FilterPopupPresenterProtocol {
    
    func load() {
        view?.setTitle(arguments.title)
        view?.reloadTableView()
        addObserver()
    }
    
    func didTapDismissButton() {
        delegate?.didTapDismissButton()
    }
    
    func didTapClearButton() {
        delegate?.didTapClearFilterButton()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return arguments.filterOptions.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> FilterCellArguments? {
        let option = arguments.filterOptions[indexPath.row]
        return FilterCellArguments(name: option.title, selectedItems: selectedItems[option.type] ?? [])
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let option = arguments.filterOptions[indexPath.row]
        delegate?.didSelectFilterOption(option.type)
    }
    
    func didTapListProductsButton() {
        delegate?.didTapDismissButton()
    }
    
    func isSearchableFilterOption(indexPath: IndexPath) -> Bool {
        let option = arguments.filterOptions[indexPath.row]
        return option.type == .category || option.type == .brand || option.type == .city || option.type == .renter
    }
    
}
