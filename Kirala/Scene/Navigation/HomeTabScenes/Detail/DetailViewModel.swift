//
//  DetailViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import Foundation
import MapKit

struct DetailProduct {
    let id: String
    let brand: String
    let name: String
    let city: String
    let price: Double
    let description: String
    let rentalPeriodRange: RentalPeriodRange
    let location: Location
    let imageUrls: [String]
    let closedRanges: [ClosedRange]
    var favoriteState: FavoriteState
}

final class DetailViewModel {
    
    // MARK: - Dependency Properties
    
    weak var delegate: DetailViewProtocol?
    
    // MARK: - Properties
    
    private let router: DetailRouterProtocol
    private let authService: AuthService
    private let productService: ProductService
    private let favoriteService: FavoriteService
    private let arguments: DetailArguments
    
    private var detailProduct: DetailProduct?
    private var detailProductMock: SearchProduct = SearchProduct.mockSearchProducts.randomElement()!
    
    private let calendar: Calendar = .current
    
    private var loadingState: LoadingState = .loading {
        didSet {
            switch loadingState {
            case .loading:
                delegate?.showLoading()
            case .loaded:
                delegate?.hideLoading(loadResult: .none)
            }
        }
    }
    
    private var currentValue: FastisValue? {
        didSet {
            if let rangeValue = self.currentValue as? FastisRange {
                let dateString = rangeValue.getString()
                let numberOfDays = rangeValue.getNumberOfDays() + 1
                let numberOfDaysString = numberOfDays.description + " " + Strings.Common.day.localized
                let combinedDateString = dateString + " / " + numberOfDaysString
                delegate?.setDateLabel(with: combinedDateString)
                
                let price = Double(detailProduct?.price ?? 0)
                let totalPrice = price * Double(numberOfDays)
                let totalPriceString = totalPrice.toCurrencyString() + " " + Strings.Common.total.localized
                let pricePerDayString = price.toCurrencyString() + " " + Strings.Common.perDay.localized
                
                let priceLabelText = totalPriceString + " / " + pricePerDayString
                
                delegate?.setPriceLabelWithTotal(
                    with: priceLabelText,
                    totalPrice: totalPrice.toCurrencyString(),
                    total: Strings.Common.total.localized,
                    perDay: Strings.Common.perDay.localized,
                    price: price.toCurrencyString()
                )
                
                delegate?.showRentButton()
                
            } else if let date = self.currentValue as? Date {
                print(date)
            } else {
                delegate?.setDateLabel(with: Strings.Common.chooseRangeRent.localized)
            }
        }
    }
    
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    private let minDate: Date = Date()
    private let maxDate = Calendar.current.date(byAdding: .month, value: 3, to: Date())!
    private let shortcuts: [FastisShortcut<FastisRange>] = [
        .today,
        .nextWeek,
        .nextMonth
    ]
    
    private let closedRanges: [FastisRange] = [
        FastisRange(
            from: Calendar.current.date(byAdding: .day, value: 9, to: Date())!.startOfDay(in: Calendar.current),
            to: Calendar.current.date(byAdding: .day, value: 12, to: Date())!.startOfDay(in: Calendar.current)
        ),
        FastisRange(
            from: Calendar.current.date(byAdding: .day, value: 20, to: Date())!.startOfDay(in: Calendar.current),
            to: Calendar.current.date(byAdding: .day, value: 25, to: Date())!.startOfDay(in: Calendar.current)
        ),
    ]
    
    // MARK: - Initializers
    
    init(router: DetailRouterProtocol, dependencies: [Dependency: Any], arguments: DetailArguments) {
        guard let authService = dependencies[.authService] as? AuthService,
              let productService = dependencies[.productService] as? ProductService,
              let favoriteService = dependencies[.favoriteService] as? FavoriteService
        else {
            fatalError("AuthService or ProductService not found")
        }
        self.router = router
        self.authService = authService
        self.productService = productService
        self.favoriteService = favoriteService
        self.arguments = arguments
    }
    
    deinit {
        removeObserver()
    }
    
    // MARK: - Private Functions
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesChanged(_:)), name: .changedFavorite, object: nil)
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: .changedFavorite, object: nil)
    }
    
    @objc private func favoritesChanged(_ notification: Notification) {
        
        
        guard let userInfo = notification.userInfo,
              let productId = userInfo[NotificationCenterOutputs.productId.rawValue] as? String,
              let isFavorite = userInfo[NotificationCenterOutputs.isFavorite.rawValue] as? Bool,
              detailProduct?.id == productId
        else {
            return
        }
        
        if isFavorite {
            delegate?.setFavoritedIcon(animated: false)
            detailProduct?.favoriteState = .favorited
        } else {
            delegate?.setNonfavoritedIcon(animated: false)
            detailProduct?.favoriteState = .nonFavorited
        }
        
    }
    
}

extension DetailViewModel: DetailViewModelProtocol {
    
    // MARK: - Lifecycle Methods
    
    func viewDidLoad() {
        
        if arguments.id == "1" {
            dateFormatter.calendar = calendar
            delegate?.prepareNavigationBar()
            delegate?.prepareUI()
            delegate?.prepareImageSlider(imageURLs: detailProductMock.imageUrls, loopingEnabled: SearchProduct.imageUrls.count > 1)
            
            delegate?.setPriceLabel(
                with: detailProductMock.price.toCurrencyString() + " " + Strings.Common.perDay.localized,
                perDay: Strings.Common.perDay.localized,
                price: detailProductMock.price.toCurrencyString()
            )
            
            delegate?.setNameLabel(with: detailProductMock.brand + " " + detailProductMock.name, brand: detailProductMock.brand, name: detailProductMock.name)
            
            delegate?.setRatingViewValues(rating: detailProductMock.review.rating, totalRatingCount: detailProductMock.review.count)
            
            
            
            delegate?.prepareCalendar(
                minDate: minDate,
                maxDate: maxDate,
                selectMonthOnHeaderTap: true,
                allowToChooseNilDate: true,
                shortcuts: shortcuts,
                closedRanges: closedRanges
            )
            switch detailProductMock.favoriteState {
            case .favorited:
                delegate?.setFavoritedIcon(animated: false)
            case .nonFavorited:
                delegate?.setNonfavoritedIcon(animated: false)
            }
        } else {
            dateFormatter.calendar = calendar
            delegate?.prepareLoadingView()
            fetchProductDetail()
        }
        
        
    }
    
    private func fetchProductDetail() {
        loadingState = .loading
        productService.getProductDetail(id: arguments.id, token: authService.getAuthToken()) { [weak self] result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    guard let product = response.data else { return }
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.detailProduct = DetailProduct(
                            id: product.id,
                            brand: product.brand,
                            name: product.name,
                            city: product.city,
                            price: product.price,
                            description: product.description,
                            rentalPeriodRange: product.rentalPeriodRange,
                            location: product.location,
                            imageUrls: product.imageUrls,
                            closedRanges: product.closedRanges,
                            favoriteState: FavoriteState(isFavorite: product.isFavorite)
                        )
                        self.loadingState = .loaded(.none)
                        delegate?.prepareNavigationBar()
                        delegate?.prepareUI()
                        delegate?.prepareConstraints()
                        delegate?.prepareImageSlider(imageURLs: product.imageUrls, loopingEnabled: SearchProduct.imageUrls.count > 1)
                        
                        delegate?.setPriceLabel(
                            with: product.price.toCurrencyString() + " " + Strings.Common.perDay.localized,
                            perDay: Strings.Common.perDay.localized,
                            price: product.price.toCurrencyString()
                        )
                        
                        delegate?.setNameLabel(with: product.brand + " " + product.name, brand: product.brand, name: product.name)
                        
                        delegate?.setRatingViewValues(rating: Double(Int.random(in: 0...5)), totalRatingCount: Int.random(in: 0...100))
                        
                        delegate?.setDescriptionLabel(with: product.description)
                        delegate?.showMapView(with: CLLocationCoordinate2D(latitude: product.location.latitude, longitude: product.location.longitude), annotationTitle: product.location.annotationTitle ?? product.city)
                        
                        delegate?.prepareCalendar(
                            minDate: minDate,
                            maxDate: maxDate,
                            selectMonthOnHeaderTap: true,
                            allowToChooseNilDate: true,
                            shortcuts: shortcuts,
                            closedRanges: closedRanges
                        )
                        
                        if product.isFavorite {
                            delegate?.setFavoritedIcon(animated: false)
                        } else {
                            delegate?.setNonfavoritedIcon(animated: false)
                        }
                        
                    }
                    
                case .failure(let error):
                    self.loadingState = .loaded(.none)
                    self.delegate?.showEmptyState(with: .error(error))
                }
            }
        }
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidAppear() {
        delegate?.addSwipeGesture()
    }
    
    func viewDidDisappear() {
        delegate?.removeSwipeGesture()
    }
    
    func viewDidLayoutSubviews() {
        if arguments.id == "1" {
            delegate?.prepareConstraints()
        }
    }
    
    // MARK: - Actions
    
    func didTapEmptyStateActionButton() {
        if arguments.id == "1" {
            router.navigate(to: .back)
        } else {
            guard authService.isLoggedIn else {
                router.navigate(to: .back)
                return
            }
            fetchProductDetail()
        }
    }
    
    func didTapCancelButton() {
        router.navigate(to: .back)
    }
    
    func didTapShareButton() {
        delegate?.share(items: ["Share this product!"])
    }
    
    func didTapSearchButton() {
        router.navigate(to: .search(.noneSearch))
    }
    
    func didTapRentButton() {
        if let currentValue = currentValue {
            
            guard let authToken = authService.getAuthToken(), let id = detailProduct?.id  else { return }
            loadingState = .loading
            productService.rentProduct(productId: id, token: authToken) { [weak self] result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.delegate?.showAlert(with: AlertMessage(
                            title: "Success",
                            message: "Successfully mail send for your request to product owner",
                            actionTitle: Strings.Common.ok.localized
                        ))
                        self.loadingState = .loaded(.none)
                    }
                case .failure(_):
                    print("Failure")
                }
            }
            
            
        }
    }
    
    func didTapCalendarButton() {
        delegate?.showCalendar(with: currentValue)
    }
    
    func didSelectCalendarValue(with value: FastisValue?) {
        currentValue = value
    }
    
    func didTapFavoriteButton() {
        
        guard authService.isLoggedIn else {
            
            delegate?.showActionSheet(
                title: Strings.Alert.noLoginTitle.localized,
                message: Strings.Alert.noLoginFavoriteProductMessage.localized,
                actionTitle: Strings.Alert.noLoginAction.localized,
                completion: { [weak self] in
                    self?.router.navigate(to: .auth)
                }
            )
            
            return
            
        }
        
        detailProduct?.favoriteState.toggle()
        
        switch detailProduct?.favoriteState {
        case .favorited:
            delegate?.setFavoritedIcon(animated: true)
        case .nonFavorited:
            delegate?.setNonfavoritedIcon(animated: true)
        case .none:
            break
        }
        
        notifyFavoriteProductChanged(id: detailProduct?.id ?? "", isFavorite: detailProduct?.favoriteState.isFavorite ?? false)
        toogleProductFavoriteState(with: detailProduct?.id ?? "")
        
    }
    
    private func toogleProductFavoriteState(with id: String) {
        guard let token = authService.getAuthToken() else { return }
        favoriteService.toggleFavorite(productId: id, token: token) { result in}
    }
    
    private func notifyFavoriteProductChanged(id: String, isFavorite: Bool) {
        NotificationCenter.default.post(
            name: .changedFavorite,
            object: nil,
            userInfo: [
                NotificationCenterOutputs.productId.rawValue: id,
                NotificationCenterOutputs.isFavorite.rawValue: isFavorite
            ]
        )
    }
    
}

