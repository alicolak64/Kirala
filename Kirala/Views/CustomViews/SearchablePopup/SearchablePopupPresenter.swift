//
//  SearchablePopupPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 31.05.2024.
//

import Foundation

enum SearchablePopupType: CaseIterable {
    case category
    case brand
    case city
    case renter
    
    func convertFilterType() -> FilterType {
        switch self {
        case .category:
            return .category
        case .brand:
            return .brand
        case .city:
            return .city
        case .renter:
            return .renter
        }
    }
}

struct SearchablePopupArguments {
    let title: String
    let type: SearchablePopupType
    let items: [SearchablePopupItem]
    static func mockData(type: SearchablePopupType) -> SearchablePopupArguments {
        switch type {
        case .category:
            let categories = (1...20).map { SearchablePopupItem(name: "Category \($0)", selectionState: .unselected)}
            return SearchablePopupArguments(title: Localization.filter.localizedString(for: "CATEGORY"), type: .category, items: categories)
        case .brand:
            let brands = (1...20).map { SearchablePopupItem(name: "Brand \($0)", selectionState: .unselected)}
            return SearchablePopupArguments(title: Localization.filter.localizedString(for: "BRAND"), type: .brand, items: brands)
        case .city:
            let cities = [
                "Istanbul", "Ankara", "Izmir", "Bursa", "Adana", "Gaziantep", "Konya",
                "Antalya", "Kayseri", "Mersin", "Eskisehir", "Diyarbakir", "Samsun",
                "Denizli", "Sanliurfa", "Malatya", "Erzurum", "Sakarya", "Trabzon", "Balikesir",
                "Manisa", "Kocaeli", "Hatay", "Tekirdag", "Aydin", "Isparta", "Canakkale"
            ]
            let items = cities.map { SearchablePopupItem(name: $0, selectionState: .unselected)}
            return SearchablePopupArguments(title: Localization.filter.localizedString(for: "City"), type: .city, items: items)
        case .renter:
            let renters = (1...20).map { SearchablePopupItem(name: "Renter \($0)", selectionState: .unselected)}
            return SearchablePopupArguments(title: Localization.filter.localizedString(for: "RENTER"), type: .renter, items: renters)
        }
    }

}

class SearchablePopupItem: Selectable {
    let name: String
    var selectionState: SelectionState
    init(name: String, selectionState: SelectionState) {
        self.name = name
        self.selectionState = selectionState
    }
}

protocol SearchablePopupDelegate: AnyObject {
    func didTapBackButton()
    func didTapApplyButton(with selectedItems: [SearchablePopupItem], type: SearchablePopupType)
    func viewWillDisappear(with selectedItems: [SearchablePopupItem], type: SearchablePopupType)
}

protocol SearchablePopupPresenterProtocol {
    var delegate: SearchablePopupDelegate? { get set }
    func load()
    func viewWillDisappear()
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> SelectCellArguments?
    func heightForRow(at indexPath: IndexPath) -> CGFloat
    func didSelectRow(at indexPath: IndexPath)
    
    func didTapBackButton()
    func didTapClearOrSelectAllButton()
    func didTapApplyButton()
    
    func textDidChange(_ searchText: String)
}

protocol SearchablePopupViewProtocol: AnyObject {
    func setTitle(_ title: String)
    func setSearchBarPlaceholder(_ placeholder: String)
    func setRightActionButtonTitle(_ title: String)
    func reloadTableView()
    func reloadRows(at indexPaths: [IndexPath])
}

final class SearchablePopupPresenter {
    // MARK: - Properties
    
    weak var delegate: SearchablePopupDelegate?
    private weak var view: SearchablePopupViewProtocol?
    private let arguments: SearchablePopupArguments
    
    private var items: [SearchablePopupItem]
    private var filteredItems: [SearchablePopupItem] = []
    
    private var isClearButton: Bool
    private var isSearchActive: Bool = false
    
    // MARK: - Init
    
    init(view: SearchablePopupViewProtocol?, arguments: SearchablePopupArguments) {
        self.view = view
        self.arguments = arguments
        self.items = arguments.items
        self.isClearButton = items.contains { $0.selectionState == .selected }
    }
    
    private func updateClearButtonState() {
        view?.setRightActionButtonTitle(isClearButton ? Localization.filter.localizedString(for: "CLEAR").uppercased() : Localization.filter.localizedString(for: "SELECT_ALL").uppercased())
    }
    
    private func getItems() -> [SearchablePopupItem] {
        isSearchActive ? filteredItems : items
    }
    
    private func toggleItemSelection(at indexPath: IndexPath) {
        let item = getItems()[indexPath.row]
        item.selectionState.toggle()
        view?.reloadRows(at: [indexPath])
    }
    
    private func clearAllSelections() {
        let items = getItems()
        items.forEach { $0.selectionState = .unselected }
        view?.reloadTableView()
    }
    
    private func selectAllItems() {
        let items = getItems()
        items.forEach { $0.selectionState = .selected }
        view?.reloadTableView()
    }
    
}

extension SearchablePopupPresenter: SearchablePopupPresenterProtocol {
    
    func load() {
        view?.setTitle(arguments.title)
        view?.setSearchBarPlaceholder(Localization.filter.localizedString(for: "SEARCH"))
        updateClearButtonState()
        view?.reloadTableView()
    }
    
    func viewWillDisappear() {
        delegate?.viewWillDisappear(with: items, type: arguments.type)
    }
    
    func didTapBackButton() {
        delegate?.didTapBackButton()
    }
    
    func didTapClearOrSelectAllButton() {
        isClearButton ? clearAllSelections() : selectAllItems()
        isClearButton.toggle()
        updateClearButtonState()
    }
    
    func didTapApplyButton() {
        let selectedItems = items.filter { $0.selectionState == .selected }
        delegate?.didTapApplyButton(with: selectedItems, type: arguments.type)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        getItems().count
    }
    
    func cellForRow(at indexPath: IndexPath) -> SelectCellArguments? {
        let item = getItems()[indexPath.row]
        return SelectCellArguments(name: item.name, selectionState: item.selectionState)
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        toggleItemSelection(at: indexPath)
    }
    
    func textDidChange(_ searchText: String) {
        isSearchActive = !searchText.trimmed.isEmpty
        filteredItems = items.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        view?.reloadTableView()
    }
    
}
