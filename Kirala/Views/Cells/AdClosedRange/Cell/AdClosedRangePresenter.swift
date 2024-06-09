//
//  AdClosedRangePresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 9.06.2024.
//

import UIKit

/// Arguments to configure the category cell.
struct AdClosedRangeCellArguments {
    let indexPath: IndexPath
    let range: FastisValue?
    let isLast: Bool
}

protocol AdClosedRangeCellDelegate: AnyObject {
    /// Called when the "All" button is tapped.
    func didTapDeleteButton(with indexPath: IndexPath)
    func didTapDateLabel(with indexPath: IndexPath)
}


/// Protocol defining the methods for the Ad Cell Presenter.
protocol AdClosedRangeCellPresenterProtocol {
    /// Loads the data and configures the view.
    func load()
    func didTapDeleteButton()
    func didTapDateLabel()
}

/// Protocol defining the methods for the Ad Cell view.
protocol AdClosedRangeCellViewProtocol: AnyObject {
    var presenter: AdClosedRangeCellPresenterProtocol! { get set }
    func setPlaceholder(_ title: String)
    func setDateLabel(_ date: String)
    func showBottomSeparator()
    func hideBottomSeparator()
}

/// Presenter class for the Ad Cell.
final class AdClosedRangeCellPresenter {
    // MARK: - Properties
    
    private weak var view: AdClosedRangeCellViewProtocol?
    weak var delegate: AdClosedRangeCellDelegate?
    private let arguments: AdClosedRangeCellArguments
    
    // MARK: - Init
    
    /// Initializes the presenter with a view, arguments, and type.
    /// - Parameters:
    ///   - view: The view that conforms to `AdClosedRangeCellViewProtocol`.
    ///   - arguments: The arguments to configure the view.
    ///   - type: The type of the category cell.
    init(view: AdClosedRangeCellViewProtocol?, arguments: AdClosedRangeCellArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - AdClosedRangeCellPresenterProtocol

extension AdClosedRangeCellPresenter: AdClosedRangeCellPresenterProtocol {
    
    /// Loads the data and configures the view.
    func load() {
        
        guard let range = arguments.range else {
            view?.setPlaceholder(Strings.Ad.closedRangePlaceholder.localized)
            return
        }
        
        if let range = range as? FastisRange {
            let dateString = range.getString()
            let numberOfDays = range.getNumberOfDays() + 1
            let numberOfDaysString = numberOfDays.description + " " + Strings.Common.day.localized
            let combinedDateString = dateString + " / " + numberOfDaysString
            view?.setDateLabel(combinedDateString)
        }
        
        if !arguments.isLast {
            view?.showBottomSeparator()
        } else {
            view?.hideBottomSeparator()
        }
        
    }
    
    func didTapDeleteButton() {
        delegate?.didTapDeleteButton(with: arguments.indexPath)
    }
    
    func didTapDateLabel() {
        delegate?.didTapDateLabel(with: arguments.indexPath)
    }
    
}
