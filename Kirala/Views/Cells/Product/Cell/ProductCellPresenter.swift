//
//  ProductCellPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import Foundation

/// Arguments to configure the product cell.
struct ProductCellArguments {
    let brand: String
    let name: String
    let imageURL: String
    let price: String
    let favoriteState: FavoriteState
    let indexPath: IndexPath
}

/// Protocol defining the methods for the Product Cell Presenter.
protocol ProductCellPresenterProtocol {
    var delegate: ProductCellDelegate? { get set }
    /// Loads the data and configures the view.
    func load()
    func updateFavoriteIcon(state: FavoriteState)
    func didTapFavoriteButton()
}

/// Protocol defining the delegate methods for the Product Cell.
protocol ProductCellDelegate: AnyObject {
    /// Called when the favorite button is tapped.
    /// - Parameter indexPath: The index path of the cell.
    func didTapFavoriteButton(at indexPath: IndexPath)
}

/// Protocol defining the methods for the Product Cell view.
protocol ProductCellViewProtocol: AnyObject {
    var presenter: ProductCellPresenterProtocol! { get set }
    func setName(with totalString: String, brand: String, name: String)
    func setImageURL(_ imageURL: URL)
    func setPrice(_ price: String)
    func setPerDayString(_ perDayString: String)
    func setFavoritedIcon(animated: Bool)
    func setNonfavoritedIcon(animated: Bool)
}

/// Presenter class for the Product Cell.
final class ProductCellPresenter {
    // MARK: - Properties
    
    weak var delegate: ProductCellDelegate?
    private weak var view: ProductCellViewProtocol?
    private let arguments: ProductCellArguments
        
    // MARK: - Init
    
    /// Initializes the presenter with a view and arguments.
    /// - Parameters:
    ///   - view: The view that conforms to `ProductCellViewProtocol`.
    ///   - arguments: The arguments to configure the view.
    init(view: ProductCellViewProtocol?, arguments: ProductCellArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - ProductCellPresenterProtocol

extension ProductCellPresenter: ProductCellPresenterProtocol {
    
    /// Loads the data and configures the view.
    func load() {
        view?.setName(with: arguments.brand + " " + arguments.name, brand: arguments.brand, name: arguments.name)
        view?.setImageURL(arguments.imageURL.imageUrl)
        view?.setPrice(arguments.price)
        view?.setPerDayString(Localization.common.localizedString(for: "PER_DAY"))
        switch arguments.favoriteState {
        case .favorited:
            view?.setFavoritedIcon(animated: false)
        case .nonFavorited:
            view?.setNonfavoritedIcon(animated: false)
        }
    }
    
    func updateFavoriteIcon(state: FavoriteState) {
        switch state {
        case .favorited:
            view?.setFavoritedIcon(animated: true)
        case .nonFavorited:
            view?.setNonfavoritedIcon(animated: true)
        }
    }
    
    func didTapFavoriteButton() {
        delegate?.didTapFavoriteButton(at: arguments.indexPath)
    }
    
}
