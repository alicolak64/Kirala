//
//  UIApplication+Extensions.swift
//  UniTurkey
//
//  Created by Ali Çolak on 5.04.2024.
//

import UIKit

extension UIApplication {
    
    // MARK: - Properties
    
    static let appVersion: String = {
        if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            return appVersion
        } else {
            return ""
        }
    }()
    
    static let appBuild: String = {
        if let appBuild = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String {
            return appBuild
        } else {
            return ""
        }
    }()
    
    static func appVersionAndBuild() -> String {
        let releaseVersion = "v. " + appVersion
        let buildVersion = " b. " + appBuild
        return releaseVersion + buildVersion
    }
    
}
