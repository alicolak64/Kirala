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
    case noAds
    case emptyCart
    case noNotification
    case noOrder
    case noLoginCart
    case noLoginNotification
    case noLoginOrder
    case noLoginAds
    case noLoginProfile
    case invalidOrExpireToken
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
        case .noAds:
            return NoAdsState()
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
        case .invalidOrExpireToken:
            return InvalidOrExpireTokenState()
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
    var title: String { return Strings.EmptyState.unknownErrorTitle.localized }
    var description: String { return Strings.EmptyState.unknownErrorDesc.localized }
    var buttonTitle: String { return Strings.EmptyState.unknownErrorButton.localized }
    var imageTintColor: UIColor { return ColorPalette.appPrimary.color }
    var buttonBackgroundColor: UIColor { return ColorPalette.appPrimary.color }
    var buttonTitleColor: UIColor { return ColorText.white.color }
}

struct NoDataState: EmptyStateProtocol {
    var image: UIImage? = Symbols.listBulletBelowRectangle.symbol()
    var title: String = Strings.EmptyState.noDataTitle.localized
    var description: String = Strings.EmptyState.noDataDesc.localized
    var buttonTitle: String = Strings.EmptyState.noDataButton.localized
}

struct NoInternetState: EmptyStateProtocol {
    var image: UIImage? = Symbols.wifiSlash.symbol()
    var title: String = Strings.EmptyState.noInternetTitle.localized
    var description: String = Strings.EmptyState.noInternetDesc.localized
    var buttonTitle: String = Strings.EmptyState.noInternetButton.localized
}

struct NoSearchResultState: EmptyStateProtocol {
    var image: UIImage? = Symbols.magnifyingglassCircleFill.symbol()
    var title: String = Strings.EmptyState.noSearchResultTitle.localized
    var description: String = Strings.EmptyState.noSearchResultDesc.localized
    var buttonTitle: String = Strings.EmptyState.noSearchResultButton.localized
}

struct NoFavoritesState: EmptyStateProtocol {
    var image: UIImage? = Symbols.starSlashFill.symbol()
    var title: String = Strings.EmptyState.noFavoriteTitle.localized
    var description: String = Strings.EmptyState.noFavoriteDesc.localized
    var buttonTitle: String = Strings.EmptyState.noFavoriteButton.localized
}

struct EmptyCartState: EmptyStateProtocol {
    var image: UIImage? = Symbols.cartBadgeMinus.symbol()
    var title: String = Strings.EmptyState.emptyCartTitle.localized
    var description: String = Strings.EmptyState.emptyCartDesc.localized
    var buttonTitle: String = Strings.EmptyState.emptyCartButton.localized
}

struct NoNotificationState: EmptyStateProtocol {
    var image: UIImage? = Symbols.bellSlashFill.symbol()
    var title: String = Strings.EmptyState.noNotificationTitle.localized
    var description: String = Strings.EmptyState.noNotificationDesc.localized
    var buttonTitle: String = Strings.EmptyState.noNotificationButton.localized
}

struct NoAdsState: EmptyStateProtocol {
    var image: UIImage? = Symbols.rectanglePortraitOnRectanglePortraitSlashFill.symbol()
    var title: String = Strings.EmptyState.noAdsTitle.localized
    var description: String = Strings.EmptyState.noAdsDesc.localized
    var buttonTitle: String = Strings.EmptyState.noAdsButton.localized
}

struct NoOrderState: EmptyStateProtocol {
    var image: UIImage? = Symbols.rectanglePortraitOnRectanglePortraitSlashFill.symbol()
    var title: String = Strings.EmptyState.noOrderTitle.localized
    var description: String = Strings.EmptyState.noOrderDesc.localized
    var buttonTitle: String = Strings.EmptyState.noOrderButton.localized
}

struct NoLoginCartState: EmptyStateProtocol {
    var image: UIImage? = Symbols.cartFill.symbol()
    var title: String = Strings.EmptyState.noLoginCartTitle.localized
    var description: String = Strings.EmptyState.noLoginCartDesc.localized
    var buttonTitle: String = Strings.EmptyState.noLoginCartButton.localized
}

struct NoLoginOrderState: EmptyStateProtocol {
    var image: UIImage? = Symbols.rectanglePortraitOnRectanglePortraitSlashFill.symbol()
    var title: String = Strings.EmptyState.noLoginOrderTitle.localized
    var description: String = Strings.EmptyState.noLoginOrderDesc.localized
    var buttonTitle: String = Strings.EmptyState.noLoginOrderButton.localized
}

struct NoLoginNotificationState: EmptyStateProtocol {
    var image: UIImage? = Symbols.bell.symbol()
    var title: String = Strings.EmptyState.noLoginNotificationTitle.localized
    var description: String = Strings.EmptyState.noLoginNotificationDesc.localized
    var buttonTitle: String = Strings.EmptyState.noLoginNotificationButton.localized
}

struct NoLoginProfileState: EmptyStateProtocol {
    var image: UIImage? = Symbols.personFill.symbol()
    var title: String = Strings.EmptyState.noLoginProfileTitle.localized
    var description: String = Strings.EmptyState.noLoginProfileDesc.localized
    var buttonTitle: String = Strings.EmptyState.noLoginProfileButton.localized
}

struct NoLoginAdsState: EmptyStateProtocol {
    var image: UIImage? = Symbols.rectanglePortraitOnRectanglePortraitSlashFill.symbol()
    var title: String = Strings.EmptyState.noLoginAdsTitle.localized
    var description: String = Strings.EmptyState.noLoginAdsDesc.localized
    var buttonTitle: String = Strings.EmptyState.noLoginAdsButton.localized
}

struct InvalidOrExpireTokenState: EmptyStateProtocol {
    var image: UIImage? = Symbols.exclamationmarkTriangleFill.symbol()
    var title: String = Strings.EmptyState.invalidOrExpireTokenTitle.localized
    var description: String = Strings.EmptyState.invalidOrExpireTokenDesc.localized
    var buttonTitle: String = Strings.EmptyState.invalidOrExpireTokenButton.localized
}

struct UnknownState: EmptyStateProtocol {
    var image: UIImage? = Symbols.exclamationmarkTriangleFill.symbol()
    var title: String = Strings.EmptyState.unknownErrorTitle.localized
    var description: String = Strings.EmptyState.unknownErrorDesc.localized
    var buttonTitle: String = Strings.EmptyState.unknownErrorButton.localized
}
