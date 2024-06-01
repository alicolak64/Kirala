import UIKit

protocol ImageSliderViewInterface: AnyObject {
    var scrollViewContentOffsetXPos: Double { get }
    var scrollViewWidth: Double { get }
    var presentedImageView: UIImageView? { get }

    func reloadCollectionView()
    func prepareCollectionView()
    func prepareSubviews()
    func scroll(to xOffset: Double, animate: Bool)
    func preparePageControl(numberOfPages: Int)
    func setPager(to page: Int)
    func setPageControllerHidden(hide: Bool)
    func showThumbnailImage(_ image: UIImage?)
    func hideThumbnailImage()
}

final class ImageSliderView: UIView {

    // MARK: Properties
    var presenter: ImageSliderViewPresenterInterface! {
        didSet {
            presenter.load()
        }
    }

    // MARK: Outlets
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.register(ImageSliderCollectionViewCell.self, forCellWithReuseIdentifier: "ImageSliderCollectionViewCell")
        return collection
    }()
    
    private lazy var pager: ImageSliderPagerView = {
        return ImageSliderPagerView(frame: .zero)
    }()
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        return imageView
    }()

    private let gradientLayer = CAGradientLayer()
    private var gradientView: UIView?

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareUI()
    }

    private func prepareUI() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(collectionView)
        addSubview(pager)
        addSubview(thumbnailImageView)
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        pager.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            pager.centerXAnchor.constraint(equalTo: centerXAnchor),
            pager.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            pager.heightAnchor.constraint(equalToConstant: 19),
            
            thumbnailImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            thumbnailImageView.topAnchor.constraint(equalTo: topAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: - ImageSliderViewInterface

extension ImageSliderView: ImageSliderViewInterface {
    func setPageControllerHidden(hide: Bool) {
        pager.isHidden = hide
    }

    func showThumbnailImage(_ image: UIImage?) {
        thumbnailImageView.image = image
        thumbnailImageView.isHidden = false
    }

    func hideThumbnailImage() {
        thumbnailImageView.isHidden = true
    }

    var presentedImageView: UIImageView? {
        guard let presenter = presenter else { return nil }
        guard let cell = collectionView.cellForItem(at: IndexPath(row: presenter.currentInnerPageIndex, section: 0)) as? ImageSliderCollectionViewCell else { return nil }
        return cell.contentImageView
    }

    func preparePageControl(numberOfPages: Int) {
        pager.pageControl.numberOfPages = numberOfPages
    }

    func setPager(to page: Int) {
        pager.pageControl.currentPage = page
    }

    func scroll(to xOffset: Double, animate: Bool) {
        collectionView.setContentOffset(CGPoint(x: CGFloat(xOffset), y: collectionView.contentOffset.y), animated: animate)
    }

    var scrollViewContentOffsetXPos: Double {
        return Double(collectionView.contentOffset.x)
    }

    var scrollViewWidth: Double {
        return Double(collectionView.frame.width)
    }

    func reloadCollectionView() {
        collectionView.reloadData()
    }

    func prepareCollectionView() {
        collectionView.register(ImageSliderCollectionViewCell.self, forCellWithReuseIdentifier: "ImageSliderCollectionViewCell")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        collectionView.collectionViewLayout.invalidateLayout()
        pager.layoutIfNeeded()
    }
    
    func prepareSubviews() {
        setNeedsLayout()
        layoutIfNeeded()
    }
}

// MARK: - UICollectionViewDataSource

extension ImageSliderView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.presentedImageUrlsCount ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSliderCollectionViewCell", for: indexPath) as? ImageSliderCollectionViewCell else { fatalError("Unable to dequeue ImageSliderCollectionViewCell") }
        let cellPresenter = ImageSliderCollectionViewCellPresenter(imageUrl: presenter.presentedImageUrls[indexPath.row], view: cell)
        cell.presenter = cellPresenter
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension ImageSliderView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard collectionView == scrollView else { return }
        presenter.scrollViewDidEndDecelerating()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ImageSliderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
