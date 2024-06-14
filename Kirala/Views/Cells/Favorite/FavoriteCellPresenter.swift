//
//  FavoriteCellPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 14.06.2024.
//

import Foundation

/// Arguments to configure the category cell.
struct FavoriteCellArguments {
    let indexPath: IndexPath
    let brand: String
    let name: String
    let imageUrl: String
    let price: String
}

protocol FavoriteCellDelegate: AnyObject {
    func didTapDeleteButton(with indexPath: IndexPath)
}


/// Protocol defining the methods for the Favorite Cell Presenter.
protocol FavoriteCellPresenterProtocol {
    
    var delegate: FavoriteCellDelegate? { get set }
    
    /// Loads the data and configures the view.
    func load()
    /// Called when the "Delete" button is tapped.
    func didTapDeleteButton()
}

/// Protocol defining the methods for the Favorite Cell view.
protocol FavoriteCellViewProtocol: AnyObject {
    var presenter: FavoriteCellPresenterProtocol! { get set }
    func setNameLabel(with totalString: String, brand: String, name: String)
    func setImageURL(_ imageUrl: URL)
    func setPriceLabel(_ price: String)
    func setPerDayLabel(_ perDay: String)
    func showBottomSeparator()
}

/// Presenter class for the Favorite Cell.
final class FavoriteCellPresenter {
    // MARK: - Properties
    
    private weak var view: FavoriteCellViewProtocol?
    weak var delegate: FavoriteCellDelegate?
    private let arguments: FavoriteCellArguments
    
    // MARK: - Init
    
    /// Initializes the presenter with a view, arguments, and type.
    /// - Parameters:
    ///   - view: The view that conforms to `FavoriteCellViewProtocol`.
    ///   - arguments: The arguments to configure the view.
    ///   - type: The type of the category cell.
    init(view: FavoriteCellViewProtocol?, arguments: FavoriteCellArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - FavoriteCellPresenterProtocol

extension FavoriteCellPresenter: FavoriteCellPresenterProtocol {
    
    /// Loads the data and configures the view.
    func load() {
        view?.setNameLabel(with: arguments.brand + " " + arguments.name, brand: arguments.brand, name: arguments.name)
        view?.setImageURL(arguments.imageUrl.imageUrl)
        view?.setPriceLabel(arguments.price + " TL")
        view?.setPerDayLabel(Strings.Common.perDay.localized)
        view?.showBottomSeparator()
    }
    
    func didTapDeleteButton() {
        delegate?.didTapDeleteButton(with: arguments.indexPath)
    }
    
}

