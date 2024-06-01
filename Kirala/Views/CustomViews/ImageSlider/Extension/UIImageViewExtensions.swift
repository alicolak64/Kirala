import Kingfisher
import UIKit

typealias ImageLoadingCompletion = (Result<UIImage, ImageLoadingError>) -> Void

enum ImageLoadingError: Error {
    case internalError(Error)
    case noImage
}

extension UIImageView {
    func setImage(with path: String?,
                  placeholder: UIImage? = nil,
                  completion: ImageLoadingCompletion? = nil) {
        guard let unwrappedPath = path?.trimmingCharacters(in: .whitespacesAndNewlines), let url = URL(string: unwrappedPath) else {
            completion?(.failure(.noImage))
            return
        }
        
        self.kf.setImage(with: url, placeholder: placeholder, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(let value):
                completion?(.success(value.image))
            case .failure(let error):
                completion?(.failure(.internalError(error)))
            }
        }
    }
}
