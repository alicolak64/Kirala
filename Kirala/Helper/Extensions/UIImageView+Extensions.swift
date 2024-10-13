//
//  Kingfisher+Extensions.swift
//  Kirala
//
//  Created by Ali Çolak on 13.10.2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    /// Loads an image using Kingfisher with a provided URL. Shows a failure image if loading fails, and tracks download progress.
    /// - Parameters:
    ///   - url: The URL of the image to be loaded.
    ///   - placeholder: The placeholder image to be shown while the image is loading (optional).
    ///   - failureImage: The image to be shown if the loading fails (optional).
    func setImage(with url: URL?,
                  placeholder: UIImage? = Images.placeholder.image,
                  failureImage: UIImage? = Images.error.image) {
        
        // Set placeholder image
        self.image = placeholder
        
        // Load the image using Kingfisher with progress tracking
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: nil,
            progressBlock: { receivedSize, totalSize in
                let percentage = (Double(receivedSize) / Double(totalSize)) * 100
                print("Download progress: \(Int(percentage))%")
                
                // You can update any progress-related UI elements here (e.g., a progress bar)
            },
            completionHandler: { result in
                switch result {
                case .success(let value):
                    // Set the loaded image
                    self.image = value.image
                    print("Image successfully loaded.")
                case .failure(let error):
                    // Set the failure image
                    self.image = failureImage
                    print("Error loading image: \(error)")
                }
            }
        )
    }
}
