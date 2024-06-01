//
//  SortPopupPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 30.05.2024.
//

import Foundation

enum SortType: CaseIterable {
    case lowToHigh
    case highToLow
    case bestseller
    case newest
    case mostRated
    case rentalPeriod
}

struct BottomPopupAttributes {
    let height: CGFloat
    let cornerRadius: CGFloat
    let presentDuration: Double
    let dismissDuration: Double
    let shouldDismissInteractivelty: Bool
    let dimmingViewAlpha: CGFloat
}

extension BottomPopupAttributes {
    static let `default` = makeDefault()
    
    static func makeDefault(height: CGFloat = 400, cornerRadius: CGFloat = 5.0, presentDuration: Double = 0.5, dismissDuration: Double = 0.5, shouldDismissInteractivelty: Bool = true, dimmingViewAlpha: CGFloat = 0.5) -> BottomPopupAttributes {
        return BottomPopupAttributes(
            height: height,
            cornerRadius: cornerRadius,
            presentDuration: presentDuration,
            dismissDuration: dismissDuration,
            shouldDismissInteractivelty: shouldDismissInteractivelty,
            dimmingViewAlpha: dimmingViewAlpha
        )
    }
}

struct SortOption {
    let title: String
    let sortType: SortType
    var selectionState: SelectionState
    
    static func makeSortOptions() -> [SortOption] {
        
        SortType.allCases.map { type in
            switch type {
            case .lowToHigh:
                return SortOption(title: Localization.filter.localizedString(for: "LOW_TO_HIGH"), sortType: type, selectionState: .selected)
            case .highToLow:
                return SortOption(title: Localization.filter.localizedString(for: "HIGH_TO_LOW"), sortType: type, selectionState: .unselected)
            case .bestseller:
                return SortOption(title: Localization.filter.localizedString(for: "BESTSELLER"), sortType: type, selectionState: .unselected)
            case .newest:
                return SortOption(title: Localization.filter.localizedString(for: "NEWEST"), sortType: type, selectionState: .unselected)
            case .mostRated:
                return SortOption(title: Localization.filter.localizedString(for: "MOST_RATED"), sortType: type, selectionState: .unselected)
            case .rentalPeriod:
                return SortOption(title: Localization.filter.localizedString(for: "RENTAL_PERIOD"), sortType: type, selectionState: .unselected)}
        }
        
    }
        
}

struct SortPopupArguments {
    let title: String
    let sortOptions: [SortOption]
}

protocol SortPopupDelegate: AnyObject {
    func didSelectSortOption(_ sortType: SortType)
}

protocol SortPopupPresenterProtocol {
    var delegate: SortPopupDelegate? { get set }
    func load()
    func getAttributes() -> BottomPopupAttributes
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath) -> SelectCellArguments?
    func heightForRow(at indexPath: IndexPath) -> CGFloat
    func didSelectRow(at indexPath: IndexPath)
}

protocol SortPopupViewProtocol: AnyObject {
    func dismiss()
    func setAttributes(_ attributes: BottomPopupAttributes)
    func setTitle(_ title: String)
    func reloadTableView()
    func reloadRows(at indexPaths: [IndexPath])
}

final class SortPopupPresenter {
    // MARK: - Properties
    
    weak var delegate: SortPopupDelegate?
    private weak var view: SortPopupViewProtocol?
    private let arguments: SortPopupArguments
    
    // MARK: - Init
    
    init(view: SortPopupViewProtocol?, arguments: SortPopupArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - SortPopupPresenterProtocol
extension SortPopupPresenter: SortPopupPresenterProtocol {
    
    func load() {
        view?.setTitle(arguments.title)
        view?.setAttributes(getAttributes())
        view?.reloadTableView()
    }
    
    func getAttributes() -> BottomPopupAttributes {
        return .default
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return arguments.sortOptions.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> SelectCellArguments? {
        let sortOption = arguments.sortOptions[indexPath.row]
        return SelectCellArguments(name: sortOption.title, selectionState: sortOption.selectionState)
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        delegate?.didSelectSortOption(arguments.sortOptions[indexPath.row].sortType)
        view?.dismiss()
    }
}
