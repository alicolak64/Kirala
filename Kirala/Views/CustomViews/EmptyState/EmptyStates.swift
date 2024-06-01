//
//  EmptyStates.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

/// Enum representing different empty states.
enum EmptyState {
    case noData
    case noInternet
    case noSearchResult
    case noFavorites
    case emptyCart
    case noNotification
    case noOrder
    case noLoginCart
    case noLoginNotification
    case noLoginOrder
    case noLoginAds
    case noLoginProfile
    case unknown
    
    /// Returns the data associated with each empty state.
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
        case .noLoginCart:
            return NoLoginCartState()
        case .noLoginNotification:
            return NoLoginNotificationState()
        case .noLoginOrder:
            return NoLoginOrderState()
        case .noLoginAds:
            return NoLoginAdsState()
        case .noLoginProfile:
            return NoLoginProfileState()
        case .unknown:
            return UnknownState()
        }
    }
}

/// Protocol defining the properties of an empty state.
protocol EmptyStateProtocol {
    var image: UIImage? { get }
    var title: String { get }
    var description: String { get }
    var buttonTitle: String { get }
    var imageTintColor: UIColor { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

/// Default implementations for the `EmptyStateProtocol`.
extension EmptyStateProtocol {
    var image: UIImage? { return Symbols.exclamationmarkTriangleFill.symbol() }
    var title: String { return Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_TITLE") }
    var description: String { return Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_DESC") }
    var buttonTitle: String { return Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_BUTTON") }
    var imageTintColor: UIColor { return ColorPalette.appPrimary.color }
    var buttonBackgroundColor: UIColor { return ColorPalette.appPrimary.color }
    var buttonTitleColor: UIColor { return ColorText.white.color }
}

struct NoDataState: EmptyStateProtocol {
    var image: UIImage? = Symbols.listBulletBelowRectangle.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_DATA_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_DATA_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_DATA_BUTTON")
}

struct NoInternetState: EmptyStateProtocol {
    var image: UIImage? = Symbols.wifiSlash.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_INTERNET_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_INTERNET_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_INTERNET_BUTTON")
}

struct NoSearchResultState: EmptyStateProtocol {
    var image: UIImage? = Symbols.magnifyingglassCircleFill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_SEARCH_RESULT_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_SEARCH_RESULT_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_SEARCH_RESULT_BUTTON")
}

struct NoFavoritesState: EmptyStateProtocol {
    var image: UIImage? = Symbols.starSlashFill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_FAVORITE_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_FAVORITE_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_FAVORITE_BUTTON")
}

struct EmptyCartState: EmptyStateProtocol {
    var image: UIImage? = Symbols.cartBadgeMinus.symbol()
    var title: String = Localization.emptyState.localizedString(for: "EMPTY_CART_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "EMPTY_CART_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "EMPTY_CART_BUTTON")
}

struct NoNotificationState: EmptyStateProtocol {
    var image: UIImage? = Symbols.bellSlashFill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_NOTIFICATION_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_NOTIFICATION_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_NOTIFICATION_BUTTON")
}

struct NoOrderState: EmptyStateProtocol {
    var image: UIImage? = Symbols.rectanglePortraitOnRectanglePortraitSlashFill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_ORDER_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_ORDER_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_ORDER_BUTTON")
}

struct NoLoginCartState: EmptyStateProtocol {
    var image: UIImage? = Symbols.cartFill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_LOGIN_CART_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_LOGIN_CART_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_LOGIN_CART_BUTTON")
}

struct NoLoginOrderState: EmptyStateProtocol {
    var image: UIImage? = Symbols.rectanglePortraitOnRectanglePortraitSlashFill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_LOGIN_ORDER_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_LOGIN_ORDER_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_LOGIN_ORDER_BUTTON")
}

struct NoLoginNotificationState: EmptyStateProtocol {
    var image: UIImage? = Symbols.bell.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_LOGIN_NOTIFICATION_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_LOGIN_NOTIFICATION_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_LOGIN_NOTIFICATION_BUTTON")
}

struct NoLoginProfileState: EmptyStateProtocol {
    var image: UIImage? = Symbols.personFill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_LOGIN_PROFILE_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_LOGIN_PROFILE_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_LOGIN_PROFILE_BUTTON")
}

struct NoLoginAdsState: EmptyStateProtocol {
    var image: UIImage? = Symbols.rectanglePortraitOnRectanglePortraitSlashFill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_LOGIN_ADS_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_LOGIN_ADS_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_LOGIN_ADS_BUTTON")
}


struct UnknownState: EmptyStateProtocol {
    var image: UIImage? = Symbols.exclamationmarkTriangleFill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_BUTTON")
}
