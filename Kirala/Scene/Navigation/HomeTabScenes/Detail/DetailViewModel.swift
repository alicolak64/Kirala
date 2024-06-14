//
//  DetailViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 21.05.2024.
//

import Foundation

final class DetailViewModel {
    
    // MARK: - Dependency Properties
    
    weak var delegate: DetailViewProtocol?
    
    // MARK: - Properties
    
    private let router: DetailRouterProtocol
    private let authService: AuthService
    
    private var detailProduct: SearchProduct = SearchProduct.mockSearchProducts.randomElement()!
    
    private let calendar: Calendar = .current
    
    private var currentValue: FastisValue? {
        didSet {
            if let rangeValue = self.currentValue as? FastisRange {
                let dateString = rangeValue.getString()
                let numberOfDays = rangeValue.getNumberOfDays() + 1
                let numberOfDaysString = numberOfDays.description + " " + Strings.Common.day.localized
                let combinedDateString = dateString + " / " + numberOfDaysString
                delegate?.setDateLabel(with: combinedDateString)
                
                let price = Double(detailProduct.price)
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
    
    init(router: DetailRouterProtocol, dependencies: [Dependency: Any]) {
        guard let authService = dependencies[.authService] as? AuthService else {
            fatalError("AuthService not found")
        }
        self.router = router
        self.authService = authService
    }
    
}

extension DetailViewModel: DetailViewModelProtocol {
    
    // MARK: - Lifecycle Methods
    
    func viewDidLoad() {
        dateFormatter.calendar = calendar
        delegate?.prepareNavigationBar()
        delegate?.prepareUI()
        delegate?.prepareImageSlider(imageURLs: detailProduct.imageUrls, loopingEnabled: SearchProduct.imageUrls.count > 1)
        
        delegate?.setPriceLabel(
            with: detailProduct.price.toCurrencyString() + " " + Strings.Common.perDay.localized,
            perDay: Strings.Common.perDay.localized,
            price: detailProduct.price.toCurrencyString()
        )
        
        delegate?.setNameLabel(with: detailProduct.brand + " " + detailProduct.name, brand: detailProduct.brand, name: detailProduct.name)
        
        delegate?.setRatingViewValues(rating: detailProduct.review.rating, totalRatingCount: detailProduct.review.count)
        
        delegate?.prepareCalendar(
            minDate: minDate,
            maxDate: maxDate,
            selectMonthOnHeaderTap: true,
            allowToChooseNilDate: true,
            shortcuts: shortcuts,
            closedRanges: closedRanges
        )
        switch detailProduct.favoriteState {
        case .favorited:
            delegate?.setFavoritedIcon(animated: false)
        case .nonFavorited:
            delegate?.setNonfavoritedIcon(animated: false)
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
        delegate?.prepareConstraints()
    }
    
    // MARK: - Actions
    
    func didTapCancelButton() {
        router.navigate(to: .back)
    }
    
    func didTapShareButton() {
        delegate?.share(items: ["Share this product!"])
    }
    
    func didTapSearchButton() {
        router.navigate(to: .search(.noneSearch))
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
        
        detailProduct.favoriteState.toggle()
        switch detailProduct.favoriteState {
        case .favorited:
            delegate?.setFavoritedIcon(animated: true)
        case .nonFavorited:
            delegate?.setNonfavoritedIcon(animated: true)
        }
    }
    
}

