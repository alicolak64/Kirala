//
//  Imageable.swift
//  UniTurkey
//
//  Created by Ali Çolak on 5.04.2024.
//

import UIKit

protocol Imageable {
    // MARK: - Properties
    var image: UIImage { get }
}

// MARK: - Default Implementation
extension Imageable {
    var image: UIImage {
        UIImage(named: String(describing: self)) ?? UIImage()
    }
}
