//
//  FilterPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 30.05.2024.
//

import Foundation

protocol FilterViewModelProtocol {
    var delegate: FilterViewDelegate? { get set }
    var view: FilterViewProtocol? { get set }
    func didTapSortButton()
    func didTapFilterButton()
}

final class FilterViewModel: FilterViewModelProtocol {
    
    // MARK: - Properties
    
    weak var delegate: FilterViewDelegate?
    weak var view: FilterViewProtocol?
    
    // MARK: - Init
    
    init() {
        
    }
        
    // MARK: - FilterPresenterProtocol
    
    func didTapSortButton() {
        delegate?.didTapSortButton()
    }
    
    func didTapFilterButton() {
        delegate?.didTapFilterButton()
    }
    
}

protocol FilterViewDelegate: AnyObject {
    func didTapSortButton()
    func didTapFilterButton()
}

protocol FilterViewProtocol: AnyObject {
    func setSortButtonTitle(_ title: String)
    func setFilterButtonTitle(_ title: String)
}

