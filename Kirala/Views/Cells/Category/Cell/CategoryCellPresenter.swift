//
//  CategoryCellPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 18.05.2024.
//

import Foundation



/// Arguments to configure the category cell.
struct CategoryCellArguments {
    let name: String
    let selectionState: SelectionState
}

/// Enum defining the type of category cell.
enum CategoryCellType {
    case home
    case search
}

/// Protocol defining the methods for the Category Cell Presenter.
protocol CategoryCellPresenterProtocol {
    /// Loads the data and configures the view.
    func load()
}

/// Protocol defining the methods for the Category Cell view.
protocol CategoryCellViewProtocol: AnyObject {
    var presenter: CategoryCellPresenterProtocol! { get set }
    func setCategoryName(_ name: String)
    func setLeadingConstraint(_ constant: CGFloat)
    func showSeperator()
    func hideSeperator()
    func prepareHomeCategoryStyle()
    func prepareSearchCategoryStyle()
    func prepareNonSelectedHomeCategoryStyle()
    func prepareNonSelectedSearchCategoryStyle()
    func prepareSelectedHomeCategoryStyle()
    func prepareSelectedSearchCategoryStyle()
}

/// Presenter class for the Category Cell.
final class CategoryCellPresenter {
    // MARK: - Properties
    
    private weak var view: CategoryCellViewProtocol?
    private let arguments: CategoryCellArguments
    private let type: CategoryCellType
    
    // MARK: - Init
    
    /// Initializes the presenter with a view, arguments, and type.
    /// - Parameters:
    ///   - view: The view that conforms to `CategoryCellViewProtocol`.
    ///   - arguments: The arguments to configure the view.
    ///   - type: The type of the category cell.
    init(view: CategoryCellViewProtocol?, arguments: CategoryCellArguments, type: CategoryCellType) {
        self.view = view
        self.arguments = arguments
        self.type = type
    }
}

// MARK: - CategoryCellPresenterProtocol

extension CategoryCellPresenter: CategoryCellPresenterProtocol {
    /// Loads the data and configures the view.
    func load() {
        view?.setCategoryName(arguments.name)
        switch type {
        case .home:
            view?.prepareHomeCategoryStyle()
            view?.setLeadingConstraint(-2)
            view?.hideSeperator()
            switch arguments.selectionState {
            case .selected:
                view?.prepareSelectedHomeCategoryStyle()
            case .unselected:
                view?.prepareNonSelectedHomeCategoryStyle()
            }
        case .search:
            view?.prepareSearchCategoryStyle()
            switch arguments.selectionState {
            case .selected:
                view?.setLeadingConstraint(12)
                view?.showSeperator()
                view?.prepareSelectedSearchCategoryStyle()
            case .unselected:
                view?.setLeadingConstraint(10)
                view?.hideSeperator()
                view?.prepareNonSelectedSearchCategoryStyle()
            }
        }
    }
}
