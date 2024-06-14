//
//  DetailContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import UIKit

protocol DetailBuilderProtocol {
    static func build(rootNavigationController: UINavigationController?, navigationController: UINavigationController?) -> UIViewController
}

enum DetailRoute {
    case back
    case search(SearchRouteOption)
    case auth
}

protocol DetailRouterProtocol {
    func navigate(to route: DetailRoute)
}

protocol DetailViewModelProtocol {
    
    // MARK: Dependency Properties
    var delegate: DetailViewProtocol? { get set }
    
    // MARK: Lifecycle Methods
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidLayoutSubviews()
    func viewDidAppear()
    func viewDidDisappear()
        
    // MARK: Actions
    func didTapCancelButton()
    func didTapShareButton()
    func didTapSearchButton()
    func didTapFavoriteButton()
    func didTapCalendarButton()
    func didSelectCalendarValue(with value: FastisValue?)

}


protocol DetailViewProtocol: AnyObject {
    
    // MARK: Methods
    
    func prepareNavigationBar()
    func prepareUI()
    func prepareConstraints()
    func prepareImageSlider(imageURLs: [String], loopingEnabled: Bool)
    func addSwipeGesture()
    func removeSwipeGesture()
    func share(items: [Any])
    func setFavoritedIcon(animated: Bool)
    func setNonfavoritedIcon(animated: Bool)
    
    func prepareCalendar(
        minDate: Date,
        maxDate: Date,
        selectMonthOnHeaderTap: Bool,
        allowToChooseNilDate: Bool,
        shortcuts: [FastisShortcut<FastisRange>],
        closedRanges: [FastisRange]
    )
    func showCalendar(with value: FastisValue?)
    func setDateLabel(with text: String)
    func setPriceLabelWithTotal(with text: String, totalPrice: String, total: String, perDay: String, price: String)
    func setPriceLabel(with text: String, perDay: String, price: String)
    func setRatingViewValues(rating: Double, totalRatingCount: Int)
    func setNameLabel(with totalString: String, brand: String, name: String)
    
    
    func showActionSheet(title: String, message: String, actionTitle: String, completion: @escaping () -> Void)

    
}
