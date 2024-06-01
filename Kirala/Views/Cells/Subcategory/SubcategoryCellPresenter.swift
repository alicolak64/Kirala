//
//  SubcategoryCellPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import Foundation

/// Arguments to configure the subcategory cell.
struct SubcategoryCellArguments {
    let name: String
    let imageURL: String
}

/// Protocol defining the methods for the Subcategory Cell Presenter.
protocol SubcategoryCellPresenterProtocol {
    /// Loads the data and configures the view.
    func load()
}

/// Protocol defining the methods for the Subcategory Cell view.
protocol SubcategoryCellViewProtocol: AnyObject {
    var presenter: SubcategoryCellPresenterProtocol! { get set }
    func setName(_ name: String)
    func setImageURL(_ imageURL: URL)
}

/// Presenter class for the Subcategory Cell.
final class SubcategoryCellPresenter {
    // MARK: - Properties
    
    private weak var view: SubcategoryCellViewProtocol?
    private let arguments: SubcategoryCellArguments
    
    // MARK: - Init
    
    /// Initializes the presenter with a view and arguments.
    /// - Parameters:
    ///   - view: The view that conforms to `SubcategoryCellViewProtocol`.
    ///   - arguments: The arguments to configure the view.
    init(view: SubcategoryCellViewProtocol?, arguments: SubcategoryCellArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - SubcategoryCellPresenterProtocol

extension SubcategoryCellPresenter: SubcategoryCellPresenterProtocol {
    /// Loads the data and configures the view.
    func load() {
        view?.setName(arguments.name)
        view?.setImageURL(arguments.imageURL.imageUrl)
    }
}
