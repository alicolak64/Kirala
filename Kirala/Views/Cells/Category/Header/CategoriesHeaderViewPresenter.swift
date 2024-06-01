//
//  CategoriesHeaderViewCellPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 18.05.2024.
//

import Foundation

/// Arguments to configure the categories header view cell.
struct CategoriesHeaderArguments {
    let name: String
    let symbol: Symbolable
}

/// Protocol defining the methods for the Categories Header View Presenter.
protocol CategoriesHeaderViewPresenterProtocol {
    var delegate: CategoriesHeaderDelegate? { get set }
    /// Loads the data and configures the view.
    func load()
    func didTapAllCategoriesButton()
}

/// Protocol defining the delegate methods for the Categories Header View.
protocol CategoriesHeaderDelegate: AnyObject {
    /// Called when the "All Categories" button is tapped.
    func didTapAllCategories()
}

/// Protocol defining the methods for the Categories Header View.
protocol CategoriesHeaderViewProtocol: AnyObject {
    var presenter: CategoriesHeaderViewPresenterProtocol! { get set }
    func setButtonSymbol(_ symbol: Symbolable)
    func setButtonTitle(_ title: String)
}

/// Presenter class for the Categories Header View.
final class CategoriesHeaderViewPresenter {
    // MARK: - Properties
    
    weak var delegate: CategoriesHeaderDelegate?
    private weak var view: CategoriesHeaderViewProtocol?
    private let arguments: CategoriesHeaderArguments
    
    // MARK: - Init
    
    /// Initializes the presenter with a view and arguments.
    /// - Parameters:
    ///   - view: The view that conforms to `CategoriesHeaderViewProtocol`.
    ///   - arguments: The arguments to configure the view.
    init(view: CategoriesHeaderViewProtocol?, arguments: CategoriesHeaderArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - CategoriesHeaderViewPresenterProtocol

extension CategoriesHeaderViewPresenter: CategoriesHeaderViewPresenterProtocol {
    
    /// Loads the data and configures the view.
    func load() {
        view?.setButtonSymbol(arguments.symbol)
        view?.setButtonTitle(arguments.name)
    }
    
    func didTapAllCategoriesButton() {
        delegate?.didTapAllCategories()
    }
}
