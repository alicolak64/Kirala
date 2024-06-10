//
//  MyOrdersNavigationBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 6.05.2024.
//

import UIKit

final class MyOrdersNavigationBuilder: NavigationBuilderProtocol {
    
    
    static func build(arguments: TabBarItemArguments) -> UINavigationController {
        let ordersViewController = OrdersViewController(dependencies: app.resolveDependencyArray(dependencies: [.authService]))
        ordersViewController.tabBarItem = UITabBarItem(title: arguments.title, image: arguments.image.symbol(), tag: arguments.tag)
        let navigationController = UINavigationController(rootViewController: ordersViewController)
        return navigationController
    }
    
}


class OrdersViewController: UIViewController {
    
    let authService: AuthService
    
    init(dependencies: [DependencyType: Any]) {
        self.authService = dependencies[.authService] as! AuthService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        guard authService.isLoggedIn else {
            emptyCardView.configure(with: .noLoginOrder)
            emptyCardView.show(withAnimation: true)
            return
        }
    }
    
}

extension OrdersViewController: EmptyStateViewDelegate {
    
    func didTapActionButton() {
        let authNavController = UINavigationController()
        let authViewController = AuthBuilder.build(rootViewController: navigationController, navigationController: authNavController)
        authNavController.viewControllers = [authViewController]
        authNavController.modalPresentationStyle = .fullScreen
        navigationController?.present(authNavController, animated: true, completion: nil)
    }
    
}


