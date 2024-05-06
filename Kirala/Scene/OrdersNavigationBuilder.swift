//
//  MyOrdersNavigationBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 6.05.2024.
//

import UIKit

final class MyOrdersNavigationBuilder: NavigationBuilderProtocol {
    
    
    static func build(arguments: TabBarItemArguments) -> UINavigationController {
        let ordersViewController = OrdersViewController()
        ordersViewController.tabBarItem = UITabBarItem(title: arguments.title, image: UIImage(systemName: arguments.image), tag: arguments.tag)
        let navigationController = UINavigationController(rootViewController: ordersViewController)
        return navigationController
    }
    
    
    
    
}


class OrdersViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Orders"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}
