//
//  Imageable.swift
//  UniTurkey
//
//  Created by Ali Çolak on 5.04.2024.
//

import UIKit

/// A protocol to handle image retrieval for conforming types.
protocol Imageable {
    // MARK: - Properties
    
    /// The image associated with the conforming type.
    var image: UIImage { get }
    
    /// The name of the image to be used. Defaults to the type name.
    var imageName: String { get }
}

// MARK: - Default Implementation

extension Imageable {
    var image: UIImage {
        return UIImage(named: imageName) ?? UIImage()
    }
    
    var imageName: String {
        return String(describing: self)
    }
}
