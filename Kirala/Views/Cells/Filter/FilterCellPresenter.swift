//
//  FilterCellPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 30.05.2024.
//

import Foundation

/// Arguments to configure the Filter cell.
struct FilterCellArguments {
    let name: String
    let selectedItems: [String]
}

/// Protocol defining the methods for the Filter Cell Presenter.
protocol FilterCellPresenterProtocol {
    /// Loads the data and configures the view.
    func load()
    func showSelectedItemsCount()
}


/// Protocol defining the methods for the Filter Cell view.
protocol FilterCellViewProtocol: AnyObject {
    var presenter: FilterCellPresenterProtocol! { get set }
    func setNameLabel(_ name: String)
    func setSelectedItemsCountLabel(_ count: Int)
    func setSelectedItemsLabel(_ selectedItemsText: String)
}

/// Presenter class for the Filter Cell.
final class FilterCellPresenter {
    // MARK: - Properties
    
    private weak var view: FilterCellViewProtocol?
    private let arguments: FilterCellArguments
    
    // MARK: - Init
    
    /// Initializes the presenter with a view, arguments, and type.
    /// - Parameters:
    ///   - view: The view that conforms to `SelectCellViewProtocol`.
    ///   - arguments: The arguments to configure the view.
    ///   - type: The type of the category cell.
    init(view: FilterCellViewProtocol?, arguments: FilterCellArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - FilterCellPresenterProtocol

extension FilterCellPresenter: FilterCellPresenterProtocol {
    /// Loads the data and configures the view.
    func load() {
        view?.setNameLabel(arguments.name)
        if !arguments.selectedItems.isEmpty {
            view?.setSelectedItemsLabel(arguments.selectedItems.joined(separator: ", "))
        }
    }
    
    func showSelectedItemsCount(){
        view?.setSelectedItemsCountLabel(arguments.selectedItems.count)
    }
}
