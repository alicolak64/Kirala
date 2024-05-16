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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Ads"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = ColorText.primary.dynamicColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emptyCardView: EmptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(with: NoInternetState())
        return view
    }()
    
    private lazy var showEmptyStateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show Empty State", for: .normal)
        button.setTitleColor(ColorPalette.appMain.dynamicColor, for: .normal)
        button.addTarget(self, action: #selector(showEmptyState), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorBackground.primary.dynamicColor
        view.addSubviews( [
            titleLabel,
            emptyCardView,
            showEmptyStateButton
        ])
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            showEmptyStateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showEmptyStateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            showEmptyStateButton.widthAnchor.constraint(equalToConstant: 150),
            
            emptyCardView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIDevice.deviceHeight * 0.15),
            emptyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emptyCardView.heightAnchor.constraint(equalToConstant: UIDevice.deviceHeight * 0.3)
            
            
        ])
        emptyCardView.delegate = self
        emptyCardView.show(withAnimation: true)
    }
    
    @objc private func showEmptyState() {
        showEmptyStateButton.isHidden = true
        emptyCardView.show(withAnimation: true)
    }
    
}

extension AdsViewController: EmptyStateViewDelegate {
    func handleOutput(_ output: EmptyStateViewOutput) {
        switch output {
        case .didTapButton:
            showEmptyStateButton.isHidden = false
        }
    }
}





