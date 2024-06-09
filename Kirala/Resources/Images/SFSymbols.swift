//
//  SFSymbols.swift
//  Kirala
//
//  Created by Ali Çolak on 13.05.2024.
//

import UIKit

enum Symbols: Symbolable {
    
    case arrowLeft
    case houseFill
    case newspaperFill
    case shippingboxFill
    case cartFill
    case personFill
    case heart
    case heartFill
    case listBulletBelowRectangle
    case wifiSlash
    case magnifyingglassCircleFill
    case starSlashFill
    case cartBadgeMinus
    case exclamationmarkTriangleFill
    case rectanglePortraitOnRectanglePortraitSlashFill
    case bell
    case bellBadge
    case bellSlashFill
    case magnifyingglass
    case squareAndArrowUp
    case eye
    case eyeSlash
    case appleLogo
    case multiply
    case checkmarkCircleFill
    case circle
    case circleInsetFilled
    case arrowUpArrowDown
    case sliderHorizontal3
    case chevronRight
    case xmark
    case chevronDown
    case chevronUp
    case plusCircleFill
    case trash
    case locationFill
    case calendar
    
    var symbolName: String {
        switch self {
        case .arrowLeft:
            return "arrow.left"
        case .houseFill:
            return "house.fill"
        case .newspaperFill:
            return "newspaper.fill"
        case .shippingboxFill:
            return "shippingbox.fill"
        case .cartFill:
            return "cart.fill"
        case .personFill:
            return "person.fill"
        case .heart:
            return "heart"
        case .heartFill:
            return "heart.fill"
        case .listBulletBelowRectangle:
            return "list.bullet.below.rectangle"
        case .wifiSlash:
            return "wifi.slash"
        case .magnifyingglassCircleFill:
            return "magnifyingglass.circle.fill"
        case .starSlashFill:
            return "star.slash.fill"
        case .cartBadgeMinus:
            return "cart.badge.minus"
        case .exclamationmarkTriangleFill:
            return "exclamationmark.triangle.fill"
        case .bellSlashFill:
            return "bell.slash.fill"
        case .rectanglePortraitOnRectanglePortraitSlashFill:
            return "rectangle.portrait.on.rectangle.portrait.slash.fill"
        case .bell:
            return "bell"
        case .bellBadge:
            return "bell.badge"
        case .magnifyingglass:
            return "magnifyingglass"
        case .squareAndArrowUp:
            return "square.and.arrow.up"
        case .eye:
            return "eye"
        case .eyeSlash:
            return "eye.slash"
        case .appleLogo:
            return "apple.logo"
        case .multiply:
            return "multiply"
        case .checkmarkCircleFill:
            return "checkmark.circle.fill"
        case .circle:
            return "circle"
        case .circleInsetFilled:
            return "circle.inset.filled"
        case .arrowUpArrowDown:
            return "arrow.up.arrow.down"
        case .sliderHorizontal3:
            return "slider.horizontal.3"
        case .chevronRight:
            return "chevron.right"
        case .xmark:
            return "xmark"
        case .chevronDown:
            return "chevron.down"
        case .chevronUp:
            return "chevron.up"
        case .plusCircleFill:
            return "plus.circle.fill"
        case .trash:
            return "trash"
        case .locationFill:
            return "location.fill"
        case .calendar:
            return "calendar"
        }
    }
    
}




