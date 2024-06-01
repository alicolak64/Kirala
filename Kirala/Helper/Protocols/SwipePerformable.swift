//
//  SwipePerformable.swift
//  Kirala
//
//  Created by Ali Çolak on 5.05.2024.
//

import UIKit

/// A protocol to add and remove swipe gestures for view controllers.
protocol SwipePerformable {
    /// Adds a swipe gesture recognizer to the view controller.
    func addSwipeGesture()
    
    /// Removes the swipe gesture recognizer from the view controller.
    func removeSwipeGesture()
}

// MARK: - Default Implementation

extension SwipePerformable where Self: UIViewController {
    func addSwipeGesture() {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(popVC))
        gesture.direction = .right
        view.addGestureRecognizer(gesture)
    }
    
    func removeSwipeGesture() {
        view.gestureRecognizers?.forEach({ gesture in
            view.removeGestureRecognizer(gesture)
        })
    }
}

// MARK: - Private Extension

fileprivate extension UIViewController {
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
}
