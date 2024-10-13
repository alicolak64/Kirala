import Kingfisher
import UIKit

typealias ImageLoadingCompletion = (Result<UIImage, ImageLoadingError>) -> Void

enum ImageLoadingError: Error {
    case internalError(Error)
    case noImage
}

extension UIImageView {
    func setImage(with path: String?,
                  placeholder: UIImage? = Images.placeholder.image,
                  failureImage: UIImage? = Images.error.image,
                  completion: ImageLoadingCompletion? = nil) {
        guard let unwrappedPath = path?.trimmingCharacters(in: .whitespacesAndNewlines), let url = URL(string: unwrappedPath) else {
            completion?(.failure(.noImage))
            self.image = failureImage
            return
        }
        
        self.setImage(with: url)
        
    }
}
