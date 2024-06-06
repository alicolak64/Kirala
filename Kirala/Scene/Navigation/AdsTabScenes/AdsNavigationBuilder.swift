//
//  MyAdsNavigationBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 6.05.2024.
//

import UIKit

final class MyAdsNavigationBuilder: NavigationBuilderProtocol {
    
    static func build(arguments: TabBarItemArguments) -> UINavigationController {
        let adsViewController = AdsViewController()
        adsViewController.tabBarItem = UITabBarItem(title: arguments.title, image: arguments.image.symbol(), tag: arguments.tag)
        let navigationController = UINavigationController(rootViewController: adsViewController)
        return navigationController
    }
    
}

class AdsViewController: UIViewController {
        
    private lazy var emptyCardView: EmptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorBackground.primary.dynamicColor
        view.addSubviews( [
            emptyCardView,
        ])
        NSLayoutConstraint.activate([
                        
            emptyCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIDevice.deviceHeight * 0.15),
            emptyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emptyCardView.heightAnchor.constraint(equalToConstant: UIDevice.deviceHeight * 0.3)
            
            
        ])
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emptyCardView.delegate = self
        
        guard app.authService.isLoggedIn else {
            emptyCardView.configure(with: .noLoginAds)
            emptyCardView.show(withAnimation: true)
            return
        }
    }
    
    
}

extension AdsViewController: EmptyStateViewDelegate {
    
    func didTapActionButton() {
        let authNavController = UINavigationController()
        let authViewController = AuthBuilder.build(rootViewController: navigationController, navigationController: authNavController)
        authNavController.viewControllers = [authViewController]
        authNavController.modalPresentationStyle = .fullScreen
        navigationController?.present(authNavController, animated: true, completion: nil)
    }
    
}





