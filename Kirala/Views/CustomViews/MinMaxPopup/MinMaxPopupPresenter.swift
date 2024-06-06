//
//  MinMaxPopupPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 2.06.2024.
//

//
//  MinMaxPopupPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 31.05.2024.
//

import Foundation

enum MinMaxPopupType: CaseIterable {
    case price
    case rating
    case rentalPeriod
    
    func convertFilterType() -> FilterType {
        switch self {
        case .price:
            return .price
        case .rating:
            return .rating
        case .rentalPeriod:
            return .rentalPeriod
        }
    }
    
}

struct MinMaxPopupArguments {
    let title: String
    let type: MinMaxPopupType
    let items: [MinMaxPopupItem]
    static func mockData(type: MinMaxPopupType) -> MinMaxPopupArguments {
        switch type {
        case .price:
            let prices = (0...5).map { MinMaxPopupItem(minMax: MinMax(min: Double($0 * 500), max: Double($0 * 500 + 100), isCustom: false), selectionState: .unselected) }
            return MinMaxPopupArguments(
                title: Strings.Filter.price.localized,
                type: .price,
                items: prices
            )
        case .rating:
            var ratings = (1...4).map { MinMaxPopupItem(minMax: MinMax(min: Double($0), max: Double($0 + 1), isCustom: false) , selectionState: .unselected) }
            ratings.append(MinMaxPopupItem(minMax: MinMax(min: 4.5, max: 5.0, isCustom: false) , selectionState: .unselected))
            return MinMaxPopupArguments(
                title: Strings.Filter.rating.localized,
                type: .rating,
                items: ratings
            )
        case .rentalPeriod:
            let periods = (0...5).map { MinMaxPopupItem(minMax: MinMax(min: Double($0 * 5), max: Double($0 * 5 + 5), isCustom: false), selectionState: .unselected) }
            return MinMaxPopupArguments(
                title: Strings.Filter.rentalPeriod.localized,
                type: .rentalPeriod,
                items: periods
            )
        }
    }

}

enum MinMaxItemType: Int {
    case min = 1
    case max = 2
}

struct MinMax {
    var min: Double?
    var max: Double?
    let isCustom: Bool
}

struct MinMaxPopupItem: Selectable {
    var minMax: MinMax
    var selectionState: SelectionState
}

protocol MinMaxPopupDelegate: AnyObject {
    func didTapBackButton()
    func didTapApplyButton(with items: [MinMaxPopupItem], type: MinMaxPopupType)
    func viewWillDisappear(with items: [MinMaxPopupItem], type: MinMaxPopupType)
}

protocol MinMaxPopupPresenterProtocol {
    var delegate: MinMaxPopupDelegate? { get set }
    func load()
    func viewWillDisappear()
    func didEndEditingTextField(with text: String?, type: MinMaxItemType)
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> SelectCellArguments?
    func heightForRow(at indexPath: IndexPath) -> CGFloat
    func didSelectRow(at indexPath: IndexPath)
    
    func didTapBackButton()
    func didTapClearButton()
    func didTapApplyButton()
    
}

protocol MinMaxPopupViewProtocol: AnyObject {
    func setTitle(_ title: String)
    func prepareForRatingView()
    func setMinTextFieldText(_ text: String)
    func setMaxTextFieldText(_ text: String)
    func setClearButtonActive(_ isActive: Bool)
    func reloadTableView()
    func reloadRows(at indexPaths: [IndexPath])
    func showAlert(alertMessage: AlertMessage)
}

final class MinMaxPopupPresenter {
    // MARK: - Properties
    
    weak var delegate: MinMaxPopupDelegate?
    private weak var view: MinMaxPopupViewProtocol?
    private let arguments: MinMaxPopupArguments
    private var items: [MinMaxPopupItem]
    
    
    // MARK: - Init
    
    init(view: MinMaxPopupViewProtocol?, arguments: MinMaxPopupArguments) {
        self.view = view
        self.arguments = arguments
        self.items = arguments.items
    }
    
    private func toggleItemSelection(at indexPath: IndexPath) {
        guard let oldSelectedItemIndex = items.firstIndex(where: { $0.selectionState == .selected }) else {
            items[indexPath.row].selectionState.toggle()
            view?.reloadRows(at: [indexPath])
            return
        }
        items[oldSelectedItemIndex].selectionState.toggle()
        items[indexPath.row].selectionState.toggle()
        view?.reloadRows(at: [IndexPath(row: oldSelectedItemIndex, section: 0), indexPath])
    }
    
    private func clearAllSelections() {
        guard let selectedIndex = items.firstIndex(where: { $0.selectionState == .selected }) else {
            return
        }
        items[selectedIndex].selectionState.toggle()
        view?.reloadRows(at: [IndexPath(row: selectedIndex, section: 0)])
        view?.setMaxTextFieldText("")
        view?.setMinTextFieldText("")
        view?.setClearButtonActive(false)
    }
    
    private func getNonCustomItems() -> [MinMaxPopupItem] {
        items.filter { !$0.minMax.isCustom }
    }
    
}

extension MinMaxPopupPresenter: MinMaxPopupPresenterProtocol {
    
    
    
    func load() {
        view?.setTitle(arguments.title)
        view?.reloadTableView()
        switch arguments.type {
        case .price, .rentalPeriod:
            if let minMax = items.first(where: { $0.selectionState == .selected }) {
                view?.setMinTextFieldText(minMax.minMax.min?.formatIntAndString ?? "")
                view?.setMaxTextFieldText(minMax.minMax.max?.formatIntAndString ?? "")
                view?.setClearButtonActive(true)
            } else {
                view?.setClearButtonActive(false)
            }
        case .rating:
            view?.prepareForRatingView()
            if let _ = items.first(where: { $0.selectionState == .selected })  {
                view?.setClearButtonActive(true)
            } else {
                view?.setClearButtonActive(false)
            }
        }
    }
    
    func viewWillDisappear() {
        delegate?.viewWillDisappear(with: items, type: arguments.type)
    }
    
    func didTapBackButton() {
        delegate?.didTapBackButton()
    }
    
    func didEndEditingTextField(with text: String?, type: MinMaxItemType) {
        guard let text = text, let text = Double(text) else { return }
        let oldSelectedItemIndex = items.firstIndex(where: { $0.selectionState == .selected })
        var oldValue: Int? = nil
        if let oldSelectedItemIndex = oldSelectedItemIndex {
            if !items[oldSelectedItemIndex].minMax.isCustom {
                items[oldSelectedItemIndex].selectionState.toggle()
                view?.reloadRows(at: [IndexPath(row: oldSelectedItemIndex, section: 0)])
                switch type {
                case .min:
                    if let value = items[oldSelectedItemIndex].minMax.max {
                        oldValue = Int(value)
                    }
                case .max:
                    if let value = items[oldSelectedItemIndex].minMax.min {
                        oldValue = Int(value)
                    }
                }
            }
        }
        if let customItemIndex = items.firstIndex(where: { $0.minMax.isCustom }) {
            switch type {
            case .min:
                items[customItemIndex].minMax.min = text
                if let oldValue = oldValue {
                    items[customItemIndex].minMax.max = Double(oldValue)
                }
            case .max:
                items[customItemIndex].minMax.max = text
                if let oldValue = oldValue {
                    items[customItemIndex].minMax.min = Double(oldValue)
                }
            }
        } else {
            switch type {
            case .min:
                if let oldValue = oldValue {
                    items.append(MinMaxPopupItem(minMax: MinMax(min: text , max: Double(oldValue) , isCustom: true), selectionState: .selected))
                } else {
                    items.append(MinMaxPopupItem(minMax: MinMax(min: text , max: nil , isCustom: true), selectionState: .selected))
                }
            case .max:
                if let oldValue = oldValue {
                    items.append(MinMaxPopupItem(minMax: MinMax(min: Double(oldValue) , max: text , isCustom: true), selectionState: .selected))
                } else {
                    items.append(MinMaxPopupItem(minMax: MinMax(min: nil , max: text , isCustom: true), selectionState: .selected))
                }
            }
        }
        
        view?.setClearButtonActive(true)
    }
    
    func didTapClearButton() {
        clearAllSelections()
    }
    
    func didTapApplyButton() {
        if let selectedItem = items.first(where: { $0.selectionState == .selected }) {
            if let min = selectedItem.minMax.min, let max = selectedItem.minMax.max {
                if min > max {
                    view?.showAlert(
                        alertMessage: AlertMessage(
                            title: Strings.Common.error.localized,
                            message: Strings.Filter.minMaxError.localized,
                            actionTitle: Strings.Common.ok.localized
                        )
                    )
                    return
                }
            }
        }
        delegate?.didTapApplyButton(with: items, type: arguments.type)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        getNonCustomItems().count
    }
    
    func cellForRow(at indexPath: IndexPath) -> SelectCellArguments? {
        let item = getNonCustomItems()[indexPath.row]
        switch arguments.type {
        case .price:
            return SelectCellArguments(name: "\(item.minMax.min?.formatIntAndString ?? "") - \(item.minMax.max?.formatIntAndString ?? "") TL", selectionState: item.selectionState)
        case .rating:
            let starAndAbove = Strings.Filter.starAndAbove.localized
            guard let starValue = item.minMax.min?.formatIntAndString else { return nil }
            return SelectCellArguments(name: "\(starValue) \(starAndAbove)", selectionState: item.selectionState)
        case .rentalPeriod:
            return SelectCellArguments(name: "\(item.minMax.min?.formatIntAndString ?? "") - \(item.minMax.max?.formatIntAndString ?? "") \(Strings.Common.day.localized)", selectionState: item.selectionState)
        }
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        toggleItemSelection(at: indexPath)
        if items.first(where: { $0.minMax.isCustom }) != nil {
            items.removeAll { $0.minMax.isCustom }
        }
        guard let selectedItem = getNonCustomItems().first(where: { $0.selectionState == .selected }) else {
            view?.setMinTextFieldText("")
            view?.setMaxTextFieldText("")
            view?.setClearButtonActive(false)
            return
        }
        view?.setMinTextFieldText(selectedItem.minMax.min?.formatIntAndString ?? "")
        view?.setMaxTextFieldText(selectedItem.minMax.max?.formatIntAndString ?? "")
        view?.setClearButtonActive(true)
    }
    

}

