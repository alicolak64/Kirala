import UIKit

protocol ImageSliderCollectionViewCellInterface: AnyObject {
    func loadImage(url: String?)
    func resetImage()
}

final class ImageSliderCollectionViewCell: UICollectionViewCell {
    lazy var contentImageView: PinchableImageView = {
        let imageView = PinchableImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var presenter: ImageSliderCollectionViewCellPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentImageView.embedEdgeToEdge(in: self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetImage()
    }
}

extension ImageSliderCollectionViewCell: ImageSliderCollectionViewCellInterface {
    func resetImage() {
        contentImageView.image = nil
    }
    
    func loadImage(url: String?) {
        contentImageView.setImage(with: url)
    }
}
