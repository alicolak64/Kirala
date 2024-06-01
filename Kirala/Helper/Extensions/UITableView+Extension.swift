//
//  UITableView+Extension.swift
//  UniTurkey
//
//  Created by Ali Çolak on 5.04.2024.
//

import UIKit

/// An extension to simplify the registration and dequeuing of UITableView cells.
extension UITableView {
    
    // MARK: - Register
    
    /// Registers a UITableViewCell with the table view.
    /// - Parameter _: The type of the UITableViewCell to register.
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    // MARK: - Dequeue
    
    /// Dequeues a reusable UITableViewCell for the specified index path.
    /// - Parameter indexPath: The index path specifying the location of the cell.
    /// - Returns: A reusable UITableViewCell of the specified type.
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue UITableViewCell with identifier: \(T.identifier) at indexPath: \(indexPath)")
        }
        return cell
    }
    
    /// Dequeues a reusable UITableViewCell.
    /// - Returns: A reusable UITableViewCell of the specified type.
    func dequeueReusableCell<T: UITableViewCell>() -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier) as? T else {
            fatalError("Could not dequeue UITableViewCell with identifier: \(T.identifier)")
        }
        return cell
    }
}
