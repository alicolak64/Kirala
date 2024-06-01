//
//  ProductsHeaderPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import Foundation

/// Arguments to configure the products header.
struct ProductsHeaderArguments {
    let headerType: HeaderType
    let title: String
    let actionTitle: String
}

/// Protocol defining the methods for the Products Header Presenter.
protocol ProductsHeaderPresenterProtocol {
    var delegate: ProductsHeaderCellDelegate? { get set }
    /// Loads the data and configures the view.
    func load()
    func didTapAllProducts()
}

/// Presenter class for the Products Header Cell.
final class ProductsHeaderCellPresenter {
    // MARK: - Properties
    
    weak var delegate: ProductsHeaderCellDelegate?
    private weak var view: ProductsHeaderCellProtocol?
    private let arguments: ProductsHeaderArguments
    
    // MARK: - Init
    
    /// Initializes the presenter with a view and arguments.
    /// - Parameters:
    ///   - view: The view that conforms to `ProductsHeaderCellProtocol`.
    ///   - arguments: The arguments to configure the view.
    init(view: ProductsHeaderCellProtocol?, arguments: ProductsHeaderArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - ProductsHeaderPresenterProtocol

extension ProductsHeaderCellPresenter: ProductsHeaderPresenterProtocol {
    
    /// Loads the data and configures the view.
    func load() {
       view?.setTitle(arguments.title)
         view?.setActionTitle(arguments.actionTitle)
    }
    
    func didTapAllProducts() {
        delegate?.didTapAllProducts(headerType: arguments.headerType)
    }
}

/// Protocol defining the methods for the Products Header Cell view.
protocol ProductsHeaderCellProtocol: AnyObject {
    var presenter: ProductsHeaderPresenterProtocol! { get set }
    func setTitle(_ title: String)
    func setActionTitle(_ actionTitle: String)
}

/// Protocol defining the methods for the Products Header Cell delegate.
protocol ProductsHeaderCellDelegate: AnyObject {
    /// Called when the "All" button is tapped.
    func didTapAllProducts(headerType: HeaderType)
}
