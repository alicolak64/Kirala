//
//  UIImage+Extension.swift
//  UniTurkey
//
//  Created by Ali Çolak on 7.04.2024.
//

import UIKit

extension UIImage {
    
    // MARK: - Image Resizing
    
    /// Resizes the image to the target size while maintaining the aspect ratio.
    /// - Parameter targetSize: The desired size to resize the image to.
    /// - Returns: A new image resized to the target size.
    func resizeImage(to targetSize: CGSize) -> UIImage? {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Determine the new size while maintaining the aspect ratio
        let newSize = widthRatio > heightRatio
            ? CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
            : CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        
        // Create a new rectangle for the new image size
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Create a new image context and draw the image in the context
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Return the new image
        return newImage
    }
}
