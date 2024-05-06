//
//  BasketNavigationBuilder.swift
//  Kirala
//
//  Created by Ali Çolak on 6.05.2024.
//

import UIKit

final class BasketNavigationBuilder: NavigationBuilderProtocol {
    
    static func build(arguments: TabBarItemArguments) -> UINavigationController {
        let basketViewController = BasketViewController()
        basketViewController.tabBarItem = UITabBarItem(title: arguments.title, image: UIImage(systemName: arguments.image), tag: arguments.tag)
        let navigationController = UINavigationController(rootViewController: basketViewController)
        return navigationController
    }
    
}

class BasketViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Basket"
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
