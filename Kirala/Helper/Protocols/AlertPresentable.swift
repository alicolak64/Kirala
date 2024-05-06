//
//  Alertable.swift
//  Kirala
//
//  Created by Ali Çolak on 4.05.2024.
//

import UIKit

protocol AlertPresentable {
    func showAlert(title: String, message: String, actions: [UIAlertAction])
}

extension AlertPresentable where Self: UIViewController {
    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { action in
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
}


