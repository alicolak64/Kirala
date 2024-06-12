//
//  Notification+Center.swift
//  Kirala
//
//  Created by Ali Çolak on 31.05.2024.
//

import Foundation

extension Notification.Name {
    static let searchableFilterOptionsDidChange = Notification.Name("searchableFilterOptionsDidChange")
    static let minMaxFilterOptionsDidChange = Notification.Name("minMaxFilterOptionsDidChange")
    static let changedProduct = Notification.Name("changedProduct")
}

enum NotificationCenterOutputs: String {
    case type
    case items
    case productId
}

