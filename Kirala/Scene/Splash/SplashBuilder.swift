//
//  SplashBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 13.05.2024.
//

import UIKit

final class SplashBuilder: SplashBuilderProtocol {
    
    static func build() -> UIViewController {
        let router = SplashRouter()
        let viewModel = SplashViewModel(router: router)
        let viewController = SplashViewController(viewModel: viewModel)
        return viewController
    }
    
}
