//
//  Alertable.swift
//  Kirala
//
//  Created by Ali Çolak on 4.05.2024.
//

import UIKit

/// A protocol to present alerts in view controllers.
protocol Alertable {
    /// Presents an alert with the given title, message, and actions.
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    ///   - actions: The actions to add to the alert.
    func showAlert(title: String, message: String, actions: [UIAlertAction])
}

// MARK: - Default Implementation

extension Alertable where Self: UIViewController {
    func showAlert(title: String, message: String, actions: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { action in
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}
