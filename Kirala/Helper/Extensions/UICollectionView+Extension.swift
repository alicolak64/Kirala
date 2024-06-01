//
//  UICollectionView+Extension.swift
//  UniTurkey
//
//  Created by Ali Çolak on 5.04.2024.
//

import UIKit

/// An extension to simplify the registration and dequeuing of UICollectionView cells and supplementary views.
extension UICollectionView {
    
    // MARK: - Register
    
    /// Registers a UICollectionViewCell with the collection view.
    /// - Parameter _: The type of the UICollectionViewCell to register.
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    /// Registers a header UICollectionReusableView with the collection view.
    /// - Parameter _: The type of the UICollectionReusableView to register as a header.
    func registerHeader<T: UICollectionReusableView>(_: T.Type) where T: ReusableView {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: T.identifier)
    }
    
    /// Registers a footer UICollectionReusableView with the collection view.
    /// - Parameter _: The type of the UICollectionReusableView to register as a footer.
    func registerFooter<T: UICollectionReusableView>(_: T.Type) where T: ReusableView {
        register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: T.identifier)
    }
    
    // MARK: - Dequeue
    
    /// Dequeues a reusable UICollectionViewCell.
    /// - Parameter indexPath: The index path specifying the location of the cell.
    /// - Returns: A reusable UICollectionViewCell of the specified type.
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue UICollectionViewCell with identifier: \(T.identifier)")
        }
        return cell
    }
    
    /// Dequeues a reusable UICollectionReusableView.
    /// - Parameters:
    ///   - kind: The kind of supplementary view to dequeue.
    ///   - indexPath: The index path specifying the location of the supplementary view.
    /// - Returns: A reusable UICollectionReusableView of the specified type.
    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: String, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue UICollectionReusableView with identifier: \(T.identifier) for kind: \(kind)")
        }
        return view
    }
}
