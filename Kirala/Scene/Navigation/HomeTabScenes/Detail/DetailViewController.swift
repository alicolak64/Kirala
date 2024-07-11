//
//  DetailViewController.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import UIKit
import MapKit

final class DetailViewController: UIViewController, SwipePerformable, BackNavigatable, Shareable {
    
    // MARK: - Properties
    private let viewModel: DetailViewModel
    
    // MARK: - UI Properties
    
    private lazy var searchBarView = searchBar
    
    private lazy var shareButtonNavigationItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: Symbols.squareAndArrowUp.symbol(), style: .plain, target: self, action: #selector(shareButtonTapped))
        button.tintColor = ColorText.quaternary.dynamicColor
        return button
    }()
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emptyCardView: EmptyStateView = {
        let view = EmptyStateView()
        view.delegate = self
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = ColorBackground.primary.dynamicColor
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorBackground.primary.dynamicColor
        return view
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.makeFooterStyle()
        return view
    }()
    
    private lazy var imageSliderView: ImageSliderView = {
        let view = ImageSliderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var favoriteButton: UIView = {
        let view = UIView()
        view.backgroundColor = ColorBackground.primary.dynamicColor
        view.addRoundedBorder(width: 0.5, color: ColorPalette.border.dynamicColor)
        view.addShadow(color: ColorPalette.border.dynamicColor, opacity: 0.5, offset: .zero, radius: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapFavoriteButton)))
        return view
    }()
    
    private lazy var favoriteIcon: UIImageView = {
        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    private lazy var favoriteButtonAnimation: CAKeyframeAnimation = {
        let animation = CAKeyframeAnimation(keyPath: FavoriteAnimation.keyPath)
        animation.keyTimes = FavoriteAnimation.keyTimes
        animation.duration = FavoriteAnimation.duration
        return animation
    }()
        
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorText.primary.dynamicColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var ratingView: RatingView = {
        let view = RatingView()
        view.configure(with: .medium, type: .starAndCountAndRating)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorText.primary.dynamicColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorText.secondary.dynamicColor
        label.text = Strings.Common.chooseDate.localized
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private lazy var chooseDateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Strings.Common.chooseDate.localized, for: .normal)
        button.setTitleColor(ColorText.white.dynamicColor, for: .normal)
        button.backgroundColor = ColorPalette.appPrimary.dynamicColor
        button.addRoundedBorder(width: 0.5, color: ColorPalette.border.dynamicColor)
        button.addShadow(color: ColorPalette.border.dynamicColor, opacity: 0.5, offset: .zero, radius: 15)
        button.addTarget(self, action: #selector(didTapChooseDateButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var cartButton: UIView = {
        let view = UIView()
        view.backgroundColor = ColorBackground.primary.dynamicColor
        view.addShadow(color: ColorPalette.appPrimary.dynamicColor, opacity: 0.5, offset: .zero, radius: 15)
        view.addRoundedBorder(width: 2, color: ColorPalette.appPrimary.dynamicColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapRentButton)))
        view.isHidden = true
        return view
    }()

    private lazy var cartIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = Symbols.cartFill.symbol(size: 22)
        icon.tintColor = ColorPalette.appPrimary.dynamicColor
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()

    private lazy var cartLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorPalette.appPrimary.dynamicColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.text = Strings.Common.rent.localized
        return label
    }()
    
    private lazy var calendar: FastisController = {
        let calendar = FastisController(mode: .range)
        return calendar
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isHidden = true
        return mapView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = ColorText.primary.dynamicColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
        view.backgroundColor = ColorBackground.primary.dynamicColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.viewDidLayoutSubviews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    // MARK: - Actions
    
    func backButtonTapped() {
        viewModel.didTapCancelButton()
    }
    
    @objc func shareButtonTapped() {
        viewModel.didTapShareButton()
    }
    
    @objc func didTapFavoriteButton() {
        viewModel.didTapFavoriteButton()
    }
        
    @objc func didTapChooseDateButton() {
        viewModel.didTapCalendarButton()
    }
    
    @objc func didTapRentButton() {
        viewModel.didTapRentButton()
    }
    
}

extension DetailViewController: DetailViewProtocol {
    
    
    
    
    func showLoading() {
        loadingView.showLoading()
    }
    
    func hideLoading(loadResult: LoadingResult) {
        loadingView.hideLoading()
    }
    
    func showEmptyState(with emptyState: EmptyState) {
        emptyCardView.configure(with: emptyState)
        emptyCardView.show()
    }
    
    func prepareNavigationBar() {
        navigationItem.hidesBackButton = true
        addBackButton()
        addBottomBorder()
        navigationItem.titleView = searchBarView
        navigationItem.rightBarButtonItem = shareButtonNavigationItem
    }
    
    func prepareLoadingView() {
        view.addSubviews([
            loadingView,
            emptyCardView
        ])
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emptyCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIDevice.deviceHeight * 0.2),
            emptyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emptyCardView.heightAnchor.constraint(equalToConstant: UIDevice.deviceHeight * 0.3)
        ])
    }
    
    func prepareUI() {
        view.backgroundColor = ColorBackground.primary.dynamicColor
        
        favoriteButton.addSubview(favoriteIcon)
        
        cartButton.addSubviews([
            cartIcon,
            cartLabel
        ])
                
        footerView.addSubviews([
            priceLabel,
            dateLabel,
            chooseDateButton,
        ])
        
        contentScrollView.addSubviews([
            contentView
        ])
        
        contentView.addSubviews([
            imageSliderView,
            favoriteButton,
            nameLabel,
            cartButton,
            ratingView,
            mapView,
            descriptionLabel
        ])
        
        view.addSubviews([
            contentScrollView,
            footerView
        ])
        
    }
    
    func prepareConstraints() {
        NSLayoutConstraint.activate([
            
            contentScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentScrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.9),
            contentScrollView.widthAnchor.constraint(equalTo: view.widthAnchor),

            contentView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1500),
            
            imageSliderView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            imageSliderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageSliderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageSliderView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.85),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30),
            favoriteButton.topAnchor.constraint(equalTo: imageSliderView.topAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: imageSliderView.trailingAnchor, constant: -20),
            
            favoriteIcon.centerXAnchor.constraint(equalTo: favoriteButton.centerXAnchor),
            favoriteIcon.centerYAnchor.constraint(equalTo: favoriteButton.centerYAnchor),
            favoriteIcon.widthAnchor.constraint(equalToConstant: 20),
            favoriteIcon.heightAnchor.constraint(equalToConstant: 20),
            
            cartButton.widthAnchor.constraint(equalToConstant: 60),
            cartButton.heightAnchor.constraint(equalToConstant: 77),
            cartButton.centerYAnchor.constraint(equalTo: imageSliderView.centerYAnchor),
            cartButton.trailingAnchor.constraint(equalTo: imageSliderView.trailingAnchor, constant: -15),

            cartIcon.leadingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: 7),
            cartIcon.trailingAnchor.constraint(equalTo: cartButton.trailingAnchor, constant: -10),
            cartIcon.topAnchor.constraint(equalTo: cartButton.topAnchor,constant: 5),
            cartIcon.heightAnchor.constraint(equalToConstant: 40),

            cartLabel.topAnchor.constraint(equalTo: cartIcon.bottomAnchor, constant: 2),
            cartLabel.centerXAnchor.constraint(equalTo: cartButton.centerXAnchor),
            cartLabel.bottomAnchor.constraint(equalTo: cartButton.bottomAnchor, constant: -2),
            
            nameLabel.topAnchor.constraint(equalTo: imageSliderView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            ratingView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            ratingView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            mapView.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 10),
            mapView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mapView.heightAnchor.constraint(equalToConstant: 500),
            
            descriptionLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.1),
            
            priceLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -10),
            
            chooseDateButton.topAnchor.constraint(equalTo: priceLabel.topAnchor),
            chooseDateButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            chooseDateButton.bottomAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            chooseDateButton.widthAnchor.constraint(equalToConstant: 120)
            
        ])
    }
    
    func prepareImageSlider(imageURLs: [String], loopingEnabled: Bool) {
        let imageSliderPresenter = ImageSliderViewPresenter(imageUrls: imageURLs,
                                                            loopingEnabled: loopingEnabled,
                                                            view: imageSliderView)
        imageSliderView.presenter = imageSliderPresenter
    }
    
    func prepareCalendar(
        minDate: Date,
        maxDate: Date,
        selectMonthOnHeaderTap: Bool,
        allowToChooseNilDate: Bool,
        shortcuts: [FastisShortcut<FastisRange>],
        closedRanges: [FastisRange]
    ) {
        calendar.title = Strings.Common.chooseRangeRent.localized
        calendar.shortcuts = shortcuts
        calendar.minimumDate = minDate
        calendar.maximumDate = maxDate
        calendar.selectMonthOnHeaderTap = selectMonthOnHeaderTap
        calendar.allowToChooseNilDate = allowToChooseNilDate
        calendar.closedRanges = closedRanges
        calendar.dismissHandler = { [weak self] action in
            switch action {
            case .done(let newValue):
                self?.viewModel.didSelectCalendarValue(with: newValue)
            case .cancel:
                break
            }
        }
    }
    
    func showCalendar(with value: FastisValue?) {
        calendar.initialValue = value as? FastisRange
        calendar.present(above: self)
    }
    
    func setDateLabel(with text: String) {
        dateLabel.text = text
    }
    
    func showRentButton() {
        cartButton.isHidden = false
    }
    
    func setPriceLabelWithTotal(with text: String, totalPrice: String, total: String, perDay: String, price: String) {
        priceLabel.setAttributedText(with: text,
                                     totalPrice: totalPrice,
                                     total: total,
                                     perDay: perDay,
                                     price: price,
                                     totalPriceFont: UIFont.systemFont(ofSize: 12, weight: .semibold),
                                     totalFont: UIFont.systemFont(ofSize: 10, weight: .regular),
                                     priceFont: UIFont.systemFont(ofSize: 12, weight: .semibold),
                                     perDayFont: UIFont.systemFont(ofSize: 10, weight: .regular))
    }
    
    func setPriceLabel(with text: String, perDay: String, price: String) {
        priceLabel.setAttributedText(with: text,
                                     perDay: perDay,
                                     price: price,
                                     priceFont: UIFont.systemFont(ofSize: 14, weight: .semibold),
                                     perDayFont: UIFont.systemFont(ofSize: 12, weight: .regular))
    }
    
    func setRatingViewValues(rating: Double, totalRatingCount: Int) {
        ratingView.setRating(rating)
        ratingView.setTotalRatingCount(totalRatingCount)
    }
    
    func setNameLabel(with totalString: String, brand: String, name: String) {
        nameLabel.setAttributedText(with: totalString, brand: brand, brandFont: UIFont.systemFont(ofSize: 16, weight: .bold), name: name, nameFont: UIFont.systemFont(ofSize: 16, weight: .regular))
    }
    
    func setFavoritedIcon(animated: Bool = false) {
        if animated {
            favoriteIcon.image = Symbols.heartFill.symbol()
            favoriteIcon.tintColor = ColorPalette.appPrimary.dynamicColor
            favoriteButtonAnimation.values = FavoriteAnimation.getValues(state: .favorited)
            // finish animation run updateFavoriteFeature(isFavorite: !isFavorite)
            favoriteButton.layer.add(favoriteButtonAnimation, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + FavoriteAnimation.duration) { [weak self] in
                self?.favoriteIcon.image = Symbols.heartFill.symbol()
                self?.favoriteIcon.tintColor = ColorPalette.appPrimary.dynamicColor
            }
        } else {
            favoriteIcon.image = Symbols.heartFill.symbol()
            favoriteIcon.tintColor = ColorPalette.appPrimary.dynamicColor
        }
    }
    
    func setNonfavoritedIcon(animated: Bool = false) {
        if animated {
            favoriteIcon.image = Symbols.heartFill.symbol()
            favoriteIcon.tintColor = ColorPalette.appPrimary.dynamicColor
            favoriteButtonAnimation.values = FavoriteAnimation.getValues(state: .nonFavorited)
            // finish animation run updateFavoriteFeature(isFavorite: !isFavorite)
            favoriteButton.layer.add(favoriteButtonAnimation, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + FavoriteAnimation.duration) { [weak self] in
                self?.favoriteIcon.image = Symbols.heart.symbol()
                self?.favoriteIcon.tintColor = ColorText.primary.dynamicColor
            }
        } else {
            favoriteIcon.image = Symbols.heart.symbol()
            favoriteIcon.tintColor = ColorText.primary.dynamicColor
        }
    }
    
    func showMapView(with cgLocation: CLLocationCoordinate2D, annotationTitle: String) {
        mapView.isHidden = false
        mapView.setRegion(MKCoordinateRegion(center: cgLocation, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = cgLocation
        annotation.title = annotationTitle
        mapView.addAnnotation(annotation)
    }
    
    func setDescriptionLabel(with text: String) {
        descriptionLabel.text = text
    }
    
    func setRentButtonTitle(with text: String) {
        chooseDateButton.setTitle(text, for: .normal)
    }
    
}

extension DetailViewController: EmptyStateViewDelegate {
    

    func didTapActionButton() {
        viewModel.didTapEmptyStateActionButton()
    }
    
}

extension DetailViewController: UISearchBarDelegate, Searchable {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        viewModel.didTapSearchButton()
        return false
    }
    
}

extension DetailViewController: ActionSheetable, Alertable {
    func showAlert(with alertMessage: AlertMessage) {
        showAlert(
            title: alertMessage.title,
            message: alertMessage.message,
            actions: [UIAlertAction(title: alertMessage.actionTitle, style: .default)]
        )
    }
}
