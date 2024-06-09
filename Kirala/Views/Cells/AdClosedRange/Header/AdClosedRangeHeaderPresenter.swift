//
//  AdClosedRangeHeaderPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 9.06.2024.
//

import Foundation

/// Arguments to configure the products header.
struct AdClosedRangeHeaderArguments {
    let title: String
    let buttonSymbol: Symbolable
    let buttonTitle: String
}

/// Protocol defining the methods for the AdClosedRange Header Presenter.
protocol AdClosedRangeHeaderPresenterProtocol {
    var delegate: AdClosedRangeHeaderCellDelegate? { get set }
    /// Loads the data and configures the view.
    func load()
    func didTapAddClosedRangeButton()
}

/// Presenter class for the AdClosedRange Header Cell.
final class AdClosedRangeHeaderCellPresenter {
    // MARK: - Properties
    
    weak var delegate: AdClosedRangeHeaderCellDelegate?
    private weak var view: AdClosedRangeHeaderCellProtocol?
    private let arguments: AdClosedRangeHeaderArguments
    
    // MARK: - Init
    
    /// Initializes the presenter with a view and arguments.
    /// - Parameters:
    ///   - view: The view that conforms to `AdClosedRangeHeaderCellProtocol`.
    ///   - arguments: The arguments to configure the view.
    init(view: AdClosedRangeHeaderCellProtocol?, arguments: AdClosedRangeHeaderArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - AdClosedRangeHeaderPresenterProtocol

extension AdClosedRangeHeaderCellPresenter: AdClosedRangeHeaderPresenterProtocol {
    
    /// Loads the data and configures the view.
    func load() {
        view?.setTitle(arguments.title)
        view?.setButtonTitle(arguments.buttonTitle)
        view?.setButtonSymbol(arguments.buttonSymbol)
    }
    
    func didTapAddClosedRangeButton() {
        delegate?.didTapAddClosedRangeButton()
    }
    
}

/// Protocol defining the methods for the AdClosedRange Header Cell view.
protocol AdClosedRangeHeaderCellProtocol: AnyObject {
    var presenter: AdClosedRangeHeaderPresenterProtocol! { get set }
    func setTitle(_ title: String)
    func setButtonTitle(_ title: String)
    func setButtonSymbol(_ symbol: Symbolable)
}

/// Protocol defining the methods for the AdClosedRange Header Cell delegate.
protocol AdClosedRangeHeaderCellDelegate: AnyObject {
    /// Called when the "All" button is tapped.
    func didTapAddClosedRangeButton()
}
