//
//  SearchProductCellPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 25.05.2024.
//

import Foundation

/// Arguments to configure the search product cell.
struct SearchProductCellArguments {
    let brand: String
    let name: String
    let imageURLs: [String]
    let review: ReviewProduct
    let price: Double
    let favoriteState: FavoriteState
    let indexPath: IndexPath
}

/// Protocol defining the delegate methods for the Search Product Cell.
protocol SearchProductCellDelegate: AnyObject {
    /// Called when the favorite button is tapped.
    /// - Parameter indexPath: The index path of the cell.
    func didTapFavoriteButton(at indexPath: IndexPath)
    func didTapImageSliderView(at indexPath: IndexPath)
}

/// Protocol defining the methods for the Search Product Cell Presenter.
protocol SearchProductCellPresenterProtocol {
    var delegate: SearchProductCellDelegate? { get set }
    /// Loads the data and configures the view.
    func load()
    func updateFavoriteIcon(state: FavoriteState)
    func didTapImageSliderView()
    func didTapFavoriteButton()
}

/// Protocol defining the methods for the Search Product Cell view.
protocol SearchProductCellViewProtocol: AnyObject {
    var presenter: SearchProductCellPresenterProtocol! { get set }
    func addImageSliderViewTapGesture()
    func setName(with totalString: String, brand: String, name: String)
    func setImageURLs(_ imageURLs: [String], loopingEnabled: Bool)
    func setPrice(_ price: String)
    func setReviewCount(_ count: Int)
    func setReviewRating(_ rating: Double)
    func setFavoritedIcon(animated: Bool)
    func setNonfavoritedIcon(animated: Bool)
}

/// Presenter class for the Search Product Cell.
final class SearchProductCellPresenter {
    // MARK: - Properties
    
    weak var delegate: SearchProductCellDelegate?
    private weak var view: SearchProductCellViewProtocol?
    private let arguments: SearchProductCellArguments
        
    // MARK: - Init
    
    /// Initializes the presenter with a view and arguments.
    /// - Parameters:
    ///   - view: The view that conforms to `ProductCellViewProtocol`.
    ///   - arguments: The arguments to configure the view.
    init(view: SearchProductCellViewProtocol?, arguments: SearchProductCellArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - ProductCellPresenterProtocol

extension SearchProductCellPresenter: SearchProductCellPresenterProtocol {
    
    /// Loads the data and configures the view.
    func load() {
        view?.addImageSliderViewTapGesture()
        view?.setImageURLs(arguments.imageURLs, loopingEnabled: arguments.imageURLs.count > 1)
        view?.setName(with: arguments.brand + " " + arguments.name, brand: arguments.brand, name: arguments.name)
        view?.setReviewCount(arguments.review.count)
        view?.setReviewRating(arguments.review.rating)
        view?.setPrice(arguments.price.toCurrencyString())
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
    
    func didTapImageSliderView() {
        delegate?.didTapImageSliderView(at: arguments.indexPath)
    }
    
}
