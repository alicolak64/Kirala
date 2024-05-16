//
//  TabBarController.swift
//  Kirala
//
//  Created by Ali Çolak on 6.05.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private let viewModel: TabBarViewModel
    
    // MARK: - Init
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
}

// MARK: - TabBarViewProtocol

extension TabBarController: TabBarViewProtocol {
    
    func prepareUI() {
        tabBar.barTintColor = .white
        
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
        tabBar.backgroundColor = ColorBackground.secondary.dynamicColor
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.width, height: 0.5))
        lineView.backgroundColor = .lightGray
        
        tabBar.addSubview(lineView)
        
    }
    
    func configureViewControllers(viewControllers: [UINavigationController]) {
        self.viewControllers = viewControllers
        // add space between image and title
        for item in tabBar.items ?? [] {
            item.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 4)
        }
    }
    
    func configureInitialTabBar(index: Int) {
        selectedIndex = index
        tabBar.tintColor = ColorPalette.appMain.dynamicColor
    }
    
}

extension TabBarController: UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        tabBar.tintColor = ColorPalette.appMain.dynamicColor
        
        guard
            let barItemView = item.value(forKey: "view") as? UIView,
            let barItemImageView = barItemView.subviews.compactMap({ $0 as? UIImageView }).first
        else { return }
        
        barItemImageView.contentMode = .center
        
        animate(barItemImageView)
        
        
    }
    
    private func animate(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.1, animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 3.0, options: .curveEaseInOut, animations: {
                imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: nil)
        }
    }
    
}

