//
//  UIApplication+Extensions.swift
//  UniTurkey
//
//  Created by Ali Çolak on 5.04.2024.
//

import UIKit

/// An extension to provide additional functionality for `UIApplication`.
extension UIApplication {
    
    // MARK: - Properties
    
    /// The app's current version.
    static let appVersion: String = {
        if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return appVersion
        } else {
            return ""
        }
    }()
    
    /// The app's current build number.
    static let appBuild: String = {
        if let appBuild = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String {
            return appBuild
        } else {
            return ""
        }
    }()
    
    // MARK: - Methods
    
    /// Returns the app's version and build number as a formatted string.
    /// - Returns: A string containing the app's version and build number.
    static func appVersionAndBuild() -> String {
        let releaseVersion = "v. " + appVersion
        let buildVersion = " b. " + appBuild
        return releaseVersion + buildVersion
    }
}
