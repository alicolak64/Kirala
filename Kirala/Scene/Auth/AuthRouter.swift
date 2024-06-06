//
//  AuthRouter.swift
//  Kirala
//
//  Created by Ali Çolak on 24.05.2024.
//

import UIKit
import SafariServices

final class AuthRouter: AuthRouterProtocol {
    
    // MARK: - Properties
    private weak var rootViewController: UIViewController?
    private weak var navigationController: UINavigationController?
    
    // MARK: - Initializers
    init(rootViewController: UIViewController?, navigationController: UINavigationController?) {
        self.rootViewController = rootViewController
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func navigate(to route: AuthRoute) {
        switch route {
        case .back:
            rootViewController?.dismiss(animated: true)
        case .loginSuccess:
            let lottieVC = LottieViewController(lottie: .loginSuccess) { [weak self] in
                self?.rootViewController?.dismiss(animated: true)
            }
            lottieVC.modalPresentationStyle = .fullScreen
            navigationController?.present(lottieVC, animated: true)
        case .safari(let url):
            let safariVC = SFSafariViewController(url: url)
            safariVC.modalPresentationStyle = .popover
            if let popoverController = safariVC.popoverPresentationController {
                popoverController.sourceView = navigationController?.view
                popoverController.sourceRect = CGRect(x: navigationController?.view.bounds.midX ?? 0, y: navigationController?.view.bounds.midY ?? 0, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
            navigationController?.present(safariVC, animated: true, completion: nil)
        }
    }
    
}
