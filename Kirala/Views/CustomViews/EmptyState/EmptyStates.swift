//
//  EmptyStates.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

enum EmptyState {
    case noData
    case noInternet
    case noSearchResult
    case noFavorites
    case emptyCart
    case noNotification
    case noOrder
    case unknown
    
    var data: EmptyStateProtocol {
        switch self {
        case .noData:
            return NoDataState()
        case .noInternet:
            return NoInternetState()
        case .noSearchResult:
            return NoSearchResultState()
        case .noFavorites:
            return NoFavoritesState()
        case .emptyCart:
            return EmptyCartState()
        case .noNotification:
            return NoNotificationState()
        case .noOrder:
            return NoOrderState()
        case .unknown:
            return UnknownState()
        }
    }
}

protocol EmptyStateProtocol {
    var image: UIImage? { get }
    var title: String { get }
    var description: String { get }
    var buttonTitle: String { get }
    var imageTintColor: UIColor { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

extension EmptyStateProtocol {
    var image: UIImage? { return Symbols.exclamationmark_triangle_fill.symbol() }
    var title: String { return Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_TITLE") }
    var description: String { return Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_DESC") }
    var buttonTitle: String { return Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_BUTTON") }
    var imageTintColor: UIColor { return ColorPalette.appMain.color }
    var buttonBackgroundColor: UIColor { return ColorPalette.appMain.color }
    var buttonTitleColor: UIColor { return ColorText.white.color }
}

struct NoDataState: EmptyStateProtocol {
    var image: UIImage? = Symbols.list_bullet_below_rectangle.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_DATA_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_DATA_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_DATA_BUTTON")
}

struct NoInternetState: EmptyStateProtocol {
    var image: UIImage? = Symbols.wifi_slash.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_INTERNET_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_INTERNET_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_INTERNET_BUTTON")
}

struct NoSearchResultState: EmptyStateProtocol {
    var image: UIImage? = Symbols.magnifyingglass_circle_fill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_SEARCH_RESULT_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_SEARCH_RESULT_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_SEARCH_RESULT_BUTTON")
}

struct NoFavoritesState: EmptyStateProtocol {
    var image: UIImage? = Symbols.star_slash_fill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_FAVORITE_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_FAVORITE_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_FAVORITE_BUTTON")
}

struct EmptyCartState: EmptyStateProtocol {
    var image: UIImage? = Symbols.cart_badge_minus.symbol()
    var title: String = Localization.emptyState.localizedString(for: "EMPTY_CART_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "EMPTY_CART_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "EMPTY_CART_BUTTON")
}

struct NoNotificationState: EmptyStateProtocol {
    var image: UIImage? = Symbols.bell_slash_fill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_NOTIFICATION_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_NOTIFICATION_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_NOTIFICATION_BUTTON")
}

struct NoOrderState: EmptyStateProtocol {
    var image: UIImage? = Symbols.rectangle_portrait_on_rectangle_portrait_slash_fill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_ORDER_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_ORDER_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_ORDER_BUTTON")
}

struct UnknownState: EmptyStateProtocol {
    var image: UIImage? = Symbols.exclamationmark_triangle_fill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_BUTTON")
}
