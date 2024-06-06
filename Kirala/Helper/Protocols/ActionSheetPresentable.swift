//
//  ActionSheetable.swift
//  Kirala
//
//  Created by Ali Çolak on 4.05.2024.
//

import UIKit

/// A protocol to present action sheets in view controllers.
protocol ActionSheetable {
    /// Presents an action sheet with the given title, message, and actions.
    /// - Parameters:
    ///   - title: The title of the action sheet.
    ///   - message: The message of the action sheet.
    ///   - actions: The actions to add to the action sheet.
    func showActionSheet(title: String, message: String, actionTitle: String, completion: @escaping () -> Void)
}

// MARK: - Default Implementation

extension ActionSheetable where Self: UIViewController {
    
    func showActionSheet(title: String, message: String, actionTitle: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: Strings.Alert.cancelAction.localized, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            completion()
        }
        
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
