//
//  CampaignCellPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 19.05.2024.
//

import Foundation

/// Arguments to configure the campaign cell.
struct CampaignCellArguments {
    let imageUrl: String
    let index: Int
    let count: Int
}

/// Protocol defining the methods for the Campaign Cell Presenter.
protocol CampaignCellPresenterProtocol {
    /// Loads the data and configures the view.
    func load()
}

/// Protocol defining the methods for the Campaign Cell view.
protocol CampaignCellViewProtocol: AnyObject {
    var presenter: CampaignCellPresenterProtocol! { get set }
    func setImageURL(_ imageURL: URL)
    func setCountLabelText(_ text: String)
}

/// Presenter class for the Campaign Cell.
final class CampaignCellPresenter {
    // MARK: - Properties
    
    weak var view: CampaignCellViewProtocol?
    private let arguments: CampaignCellArguments
    
    // MARK: - Init
    
    /// Initializes the presenter with a view and arguments.
    /// - Parameters:
    ///   - view: The view that conforms to `CampaignCellViewProtocol`.
    ///   - arguments: The arguments to configure the view.
    init(view: CampaignCellViewProtocol?, arguments: CampaignCellArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - CampaignCellPresenterProtocol

extension CampaignCellPresenter: CampaignCellPresenterProtocol {
    /// Loads the data and configures the view.
    func load() {
        view?.setImageURL(arguments.imageUrl.imageUrl)
        view?.setCountLabelText("\(arguments.index + 1)/\(arguments.count)")
    }
}
