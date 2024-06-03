//
//  FilterHeaderCellPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 3.06.2024.
//

import Foundation

struct FilterHeaderCellArguments {
    let title: String
    let isAvaliableSelectedItems: Bool
    let expandedState: ExpandState
}

protocol FilterHeaderCellPresenterProtocol {
    func load()
    func updateExpandIcon(state: ExpandState)
}

protocol FilterHeaderCellViewProtocol: AnyObject {
    var presenter: FilterHeaderCellPresenterProtocol! { get set }
    func setTitleLabel(_ title: String)
    func prepareAvaliableItemStyle()
    func prepareNonAvaliableItemStyle()
    func prepareExpandedStyle()
    func prepareCollapsedStyle()
}

final class FilterHeaderCellPresenter {
    
    private weak var view: FilterHeaderCellViewProtocol?
    private let arguments: FilterHeaderCellArguments
    
    init(view: FilterHeaderCellViewProtocol?, arguments: FilterHeaderCellArguments) {
        self.view = view
        self.arguments = arguments
    }
}

extension FilterHeaderCellPresenter: FilterHeaderCellPresenterProtocol {
    func load() {
        view?.setTitleLabel(arguments.title)
        arguments.expandedState == .expanded ? view?.prepareExpandedStyle() : view?.prepareCollapsedStyle()
        arguments.isAvaliableSelectedItems ? view?.prepareAvaliableItemStyle() : view?.prepareNonAvaliableItemStyle()
    }
    
    func updateExpandIcon(state: ExpandState) {
        switch state {
        case .expanded:
            view?.prepareExpandedStyle()
        case .collapsed:
            view?.prepareCollapsedStyle()
        }
    }
}


