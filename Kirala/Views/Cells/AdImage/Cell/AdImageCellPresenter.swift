//
//  AdImageCellPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 9.06.2024.
//

import UIKit

/// Arguments to configure the category cell.
struct AdImageCellArguments {
    let index: Int
    let image: UIImage?
    let imageUrl: String?
    let isLast: Bool
}

protocol AdImageCellDelegate: AnyObject {
    /// Called when the "All" button is tapped.
    func didTapDeleteButton(with index: Int)
}


/// Protocol defining the methods for the Ad Cell Presenter.
protocol AdImageCellPresenterProtocol {
    /// Loads the data and configures the view.
    func load()
    func didTapDeleteButton()
}

/// Protocol defining the methods for the Ad Cell view.
protocol AdImageCellViewProtocol: AnyObject {
    var presenter: AdImageCellPresenterProtocol! { get set }
    func setNoImageLabelTitle(_ title: String)
    func setIndex(_ index: Int)
    func setImageView(with image: UIImage)
    func setImageURL(with imageUrl: URL)
    func showBottomSeparator()
    func hideBottomSeparator()
}

/// Presenter class for the Ad Cell.
final class AdImageCellPresenter {
    // MARK: - Properties
    
    private weak var view: AdImageCellViewProtocol?
    weak var delegate: AdImageCellDelegate?
    private let arguments: AdImageCellArguments
    
    // MARK: - Init
    
    /// Initializes the presenter with a view, arguments, and type.
    /// - Parameters:
    ///   - view: The view that conforms to `AdImageCellViewProtocol`.
    ///   - arguments: The arguments to configure the view.
    ///   - type: The type of the category cell.
    init(view: AdImageCellViewProtocol?, arguments: AdImageCellArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - AdImageCellPresenterProtocol

extension AdImageCellPresenter: AdImageCellPresenterProtocol {
    
    /// Loads the data and configures the view.
    func load() {
                        
        guard arguments.image != nil || arguments.imageUrl != nil else {
            view?.setNoImageLabelTitle(Strings.Ad.addLeastOneImage.localized)
            return
        }
        
        if let image = arguments.image {
            view?.setIndex(arguments.index + 1)
            view?.setImageView(with: image)
        }
        
        if let imageUrl = arguments.imageUrl {
            view?.setImageURL(with: imageUrl.imageUrl)
            view?.setIndex(arguments.index)
            
        }
        
        if !arguments.isLast {
            view?.showBottomSeparator()
        } else {
            view?.hideBottomSeparator()
        }
        
    }
    
    func didTapDeleteButton() {
        delegate?.didTapDeleteButton(with: arguments.index)
    }
    
}
