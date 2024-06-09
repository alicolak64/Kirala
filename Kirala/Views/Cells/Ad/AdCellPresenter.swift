//
//  AdCellPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import Foundation

/// Arguments to configure the category cell.
struct AdCellArguments {
    let brand: String
    let name: String
    let imageUrl: String
    let price: String
}


/// Protocol defining the methods for the Ad Cell Presenter.
protocol AdCellPresenterProtocol {
    /// Loads the data and configures the view.
    func load()
}

/// Protocol defining the methods for the Ad Cell view.
protocol AdCellViewProtocol: AnyObject {
    var presenter: AdCellPresenterProtocol! { get set }
    func setNameLabel(with totalString: String, brand: String, name: String)
    func setImageURL(_ imageUrl: URL)
    func setPriceLabel(_ price: String)
    func setPerDayLabel(_ perDay: String)
    func showBottomSeparator()
}

/// Presenter class for the Ad Cell.
final class AdCellPresenter {
    // MARK: - Properties
    
    private weak var view: AdCellViewProtocol?
    private let arguments: AdCellArguments
    
    // MARK: - Init
    
    /// Initializes the presenter with a view, arguments, and type.
    /// - Parameters:
    ///   - view: The view that conforms to `AdCellViewProtocol`.
    ///   - arguments: The arguments to configure the view.
    ///   - type: The type of the category cell.
    init(view: AdCellViewProtocol?, arguments: AdCellArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - AdCellPresenterProtocol

extension AdCellPresenter: AdCellPresenterProtocol {
    
    /// Loads the data and configures the view.
    func load() {
        view?.setNameLabel(with: arguments.brand + " " + arguments.name, brand: arguments.brand, name: arguments.name)
        view?.setImageURL(arguments.imageUrl.imageUrl)
        view?.setPriceLabel(arguments.price + " TL")
        view?.setPerDayLabel(Strings.Common.perDay.localized)
        view?.showBottomSeparator()
    }
}
