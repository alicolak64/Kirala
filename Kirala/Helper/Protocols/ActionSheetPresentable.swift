//
//  ActionSheetable.swift
//  Kirala
//
//  Created by Ali Çolak on 4.05.2024.
//

import UIKit

protocol ActionSheetPresentable {
    func showActionSheet(title: String, message: String, actions: [UIAlertAction])
}

extension ActionSheetPresentable where Self: UIViewController {
    
    func showActionSheet(title: String, message: String, actions: [UIAlertAction]) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { actionSheet.addAction($0) }
        present(actionSheet, animated: true, completion: nil)
    }
    
}
