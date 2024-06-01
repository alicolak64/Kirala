//
//  SelectCellPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 30.05.2024.
//

import Foundation

/// Arguments to configure the category cell.
struct SelectCellArguments {
    let name: String
    let selectionState: SelectionState
}

/// Enum defining the type of category cell.
enum SelectCellType {
    case single
    case multiple
}

/// Protocol defining the methods for the Select Cell Presenter.
protocol SelectCellPresenterProtocol {
    /// Loads the data and configures the view.
    func load()
}

/// Protocol defining the methods for the Select Cell view.
protocol SelectCellViewProtocol: AnyObject {
    var presenter: SelectCellPresenterProtocol! { get set }
    func setNameLabel(_ name: String)
    func prepareSingleSelectStyle()
    func prepareMultipleSelectStyle()
    func setNonSelectedImage()
    func setSelectedImage()
}

/// Presenter class for the Select Cell.
final class SelectCellPresenter {
    // MARK: - Properties
    
    private weak var view: SelectCellViewProtocol?
    private let arguments: SelectCellArguments
    private let type: SelectCellType
    
    // MARK: - Init
    
    /// Initializes the presenter with a view, arguments, and type.
    /// - Parameters:
    ///   - view: The view that conforms to `SelectCellViewProtocol`.
    ///   - arguments: The arguments to configure the view.
    ///   - type: The type of the category cell.
    init(view: SelectCellViewProtocol?, arguments: SelectCellArguments, type: SelectCellType) {
        self.view = view
        self.arguments = arguments
        self.type = type
    }
}

// MARK: - SelectCellPresenterProtocol

extension SelectCellPresenter: SelectCellPresenterProtocol {
    /// Loads the data and configures the view.
    func load() {
        view?.setNameLabel(arguments.name)
        switch type {
        case .single:
            view?.prepareSingleSelectStyle()
        case .multiple:
            view?.prepareMultipleSelectStyle()
        }
        
        switch arguments.selectionState {
        case .selected:
            view?.setSelectedImage()
        case .unselected:
            view?.setNonSelectedImage()
        }
    }
}
