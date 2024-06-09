//
//  AddImageHeaderPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 9.06.2024.
//

import Foundation

/// Arguments to configure the products header.
struct AdImageHeaderArguments {
    let title: String
    let buttonSymbol: Symbolable
    let buttonTitle: String
}

/// Protocol defining the methods for the AdImage Header Presenter.
protocol AdImageHeaderPresenterProtocol {
    var delegate: AdImageHeaderCellDelegate? { get set }
    /// Loads the data and configures the view.
    func load()
    func didTapAddImageButton()
}

/// Presenter class for the AdImage Header Cell.
final class AdImageHeaderCellPresenter {
    // MARK: - Properties
    
    weak var delegate: AdImageHeaderCellDelegate?
    private weak var view: AdImageHeaderCellProtocol?
    private let arguments: AdImageHeaderArguments
    
    // MARK: - Init
    
    /// Initializes the presenter with a view and arguments.
    /// - Parameters:
    ///   - view: The view that conforms to `AdImageHeaderCellProtocol`.
    ///   - arguments: The arguments to configure the view.
    init(view: AdImageHeaderCellProtocol?, arguments: AdImageHeaderArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - AdImageHeaderPresenterProtocol

extension AdImageHeaderCellPresenter: AdImageHeaderPresenterProtocol {
    
    /// Loads the data and configures the view.
    func load() {
        view?.setTitle(arguments.title)
        view?.setButtonTitle(arguments.buttonTitle)
        view?.setButtonSymbol(arguments.buttonSymbol)
    }
    
    func didTapAddImageButton() {
        delegate?.didTapAddImageButton()
    }
    
}

/// Protocol defining the methods for the AdImage Header Cell view.
protocol AdImageHeaderCellProtocol: AnyObject {
    var presenter: AdImageHeaderPresenterProtocol! { get set }
    func setTitle(_ title: String)
    func setButtonTitle(_ title: String)
    func setButtonSymbol(_ symbol: Symbolable)
}

/// Protocol defining the methods for the AdImage Header Cell delegate.
protocol AdImageHeaderCellDelegate: AnyObject {
    /// Called when the "All" button is tapped.
    func didTapAddImageButton()
}
