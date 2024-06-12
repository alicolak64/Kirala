//
//  AddAdViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import UIKit
import Photos

struct Image {
    let id: String
    let image: UIImage?
    let imageUrl: String?
}

struct Ad {
    var id: String?
    var selectedCategory: String
    var selectedSubcategory: String
    var selectedBrand: String
    var selectedCity: String
    var name: String
    var price: Double
    var description: String
    var minRentPeriod: Int
    var maxRentPeriod: Int
    var location: Location
    var closedRanges: [FastisRange]
    var images: [Image]
}


final class AddAdViewModel {
    
    // MARK: - Dependency Properties
    
    weak var delegate: AddAdViewProtocol?
    
    private let router: AddAdRouterProtocol
    private let authService: AuthService
    private let categoryService: CategoryService
    private let productService: ProductService
    private let authenticationService: AuthenticationService
    private let editArguments: EditAddAdArguments?
    
    
    private var categories = [CategoryResponse]()
    private var subCategories = [SubcategoryResponse]()
    private var cities = [CityResponse]()
    private var brands = [BrandResponse]()
    
    private var editedClosedRangeIndex: Int?
    private var editedClosedRange: FastisRange?
    
    private var ad: Ad = Ad(
        selectedCategory: "",
        selectedSubcategory: "",
        selectedBrand: "",
        selectedCity: "",
        name: "",
        price: 0,
        description: "",
        minRentPeriod: 0,
        maxRentPeriod: 0,
        location: Location(latitude: 0, longitude: 0, annotationTitle: ""),
        closedRanges: [],
        images: []
    )
    
    private let calendar: Calendar = .current
    
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
    
    private var loadingState: LoadingState = .loading {
        didSet {
            switch loadingState {
            case .loading:
                delegate?.showLoading()
            case .loaded(let result):
                self.delegate?.hideLoading(loadResult: result)
            }
        }
    }
    
    private let dispatchGroup = DispatchGroup()
    
    // MARK: - Initializers
    
    init(router: AddAdRouterProtocol, dependencies: [Dependency: Any]) {
        guard let authService = dependencies[.authService] as? AuthService,
              let categoryService = dependencies[.categoryService] as? CategoryService,
              let productService = dependencies[.productService] as? ProductService,
              let authenticationService = dependencies[.authenticationService] as? AuthenticationService else {
            fatalError("AuthService, CategoryService or AuthenticationService not found")
        }
        self.router = router
        self.authService = authService
        self.categoryService = categoryService
        self.productService = productService
        self.authenticationService = authenticationService
        self.editArguments = nil
    }
    
    init(router: AddAdRouterProtocol, arguments: EditAddAdArguments, dependencies: [Dependency: Any]) {
        guard let authService = dependencies[.authService] as? AuthService,
              let categoryService = dependencies[.categoryService] as? CategoryService,
              let productService = dependencies[.productService] as? ProductService,
              let authenticationService = dependencies[.authenticationService] as? AuthenticationService else {
            fatalError("AuthService, CategoryService or AuthenticationService not found")
        }
        self.router = router
        self.editArguments = arguments
        self.authService = authService
        self.categoryService = categoryService
        self.productService = productService
        self.authenticationService = authenticationService
    }
    
}

extension AddAdViewModel: AddAdViewModelProtocol {
    
    // MARK: - Lifecycle Methods
    
    func viewDidLoad() {

        delegate?.prepareUI()
        delegate?.prepareConstraints()
        
        if let editArguments = editArguments {
            fetchInitialEditAdData(with: editArguments)
            delegate?.prepareNavigationBar(title: Strings.Ad.updateAd.localized)
            delegate?.prepareEditAdFooter()
        } else {
            fetchInitialData()
            delegate?.prepareNavigationBar(title: Strings.Ad.addAd.localized)
            delegate?.prepareAddAdFooter()
        }
        
    }
    
    func prepareInitalConfig() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            delegate?.prepareCategoryPickerView(with: categories.map { $0.name })
            delegate?.prepareSubcategoryPickerView(with: subCategories.map { $0.name })
            delegate?.prepareBrandPickerView(with: brands.map { $0.name })
            delegate?.prepareCityPickerView(with: cities.map { $0.name })
            delegate?.prepareNameTextField()
            delegate?.preparePriceTextField()
            delegate?.prepareDescriptionTextField()
            delegate?.prepareMinMaxPeriodTextField()
            delegate?.prepareImagesTableView()
            delegate?.prepareClosedRangeTableView()
            delegate?.prepareCalendar(
                minDate: minDate,
                maxDate: maxDate,
                selectMonthOnHeaderTap: true,
                allowToChooseNilDate: false,
                shortcuts: shortcuts,
                closedRanges: ad.closedRanges
            )
        }
        
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidAppear() {
        delegate?.addTapGesture()
    }
    
    func viewDidDisappear() {
    }
    
    func viewDidLayoutSubviews() {
        
    }
    
    // MARK: - Setups
    
    private func fetchInitialData() {
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.fetchCategories()
            self.fetchBrands()
            self.fetchCities()
            
            self.dispatchGroup.notify(queue: .main) {
                self.prepareInitalConfig()
                self.loadingState = .loaded(.none)
            }
        }
        
    }
    
    private func fetchInitialEditAdData(with editArguments: EditAddAdArguments) {
        loadingState = .loading
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.fetchCategories()
            self.fetchBrands()
            self.fetchCities()
            self.fetchEditAdData(with: editArguments)
            
            self.dispatchGroup.notify(queue: .main) {
                self.prepareInitalConfig()
                self.prepareEditAdData()
                self.loadingState = .loaded(.none)
            }
        }
        
    }
    
    private func fetchEditAdData(with arguements: EditAddAdArguments) {
        guard let token = authService.getAuthToken() else { return }
        dispatchGroup.enter()
        productService.getProductById(id: arguements.id, token: token) { [weak self] result in
            defer { self?.dispatchGroup.leave() }
            guard let self = self else { return }
            switch result {
            case .success(let product):
                guard let product = product.data else { return }
                self.ad = Ad(
                    id: product.id,
                    selectedCategory: product.category,
                    selectedSubcategory: product.subcategory,
                    selectedBrand: product.brand,
                    selectedCity: product.city,
                    name: product.name,
                    price: product.price,
                    description: product.description,
                    minRentPeriod: product.rentalPeriodRange.min,
                    maxRentPeriod: product.rentalPeriodRange.max,
                    location: product.location,
                    closedRanges: product.closedRanges.map { FastisRange(from: $0.startDate, to: $0.endDate) },
                    images: product.imageUrls.map { Image(id: UUID().uuidString, image: nil, imageUrl: $0) }
                )
                self.subCategories = product.subcategories
                self.subCategories.append(SubcategoryResponse(id: "0", name: Strings.Ad.other.localized))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchCategories() {
        dispatchGroup.enter()
        categoryService.getCategoryList { [weak self] result in
            defer { self?.dispatchGroup.leave() }
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                self.categories = categories.data ?? []
                self.categories.append(CategoryResponse(id: "0", name: Strings.Ad.other.localized))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchBrands() {
        dispatchGroup.enter()
        categoryService.getBrandList { [weak self] result in
            defer { self?.dispatchGroup.leave() }
            guard let self = self else { return }
            switch result {
            case .success(let brands):
                self.brands = brands.data ?? []
                self.brands.append(BrandResponse(id: "0", name: Strings.Ad.other.localized))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchCities() {
        dispatchGroup.enter()
        categoryService.getCityList { [weak self] result in
            defer { self?.dispatchGroup.leave() }
            guard let self = self else { return }
            switch result {
            case .success(let cities):
                self.cities = cities.data ?? []
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchSubcategories(for categoryId: String) {
        loadingState = .loading
        categoryService.getSubcategoryList(categoryId: categoryId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let subcategories):
                self.subCategories = subcategories.data ?? []
                self.subCategories.append(SubcategoryResponse(id: "0", name: Strings.Ad.other.localized))
                self.loadingState = .loaded(.none)
                DispatchQueue.main.async { [weak self] in
                    let subcateories = self?.subCategories.map { $0.name }
                    guard let subcateories = subcateories else { return }
                    self?.delegate?.updatePickerViewDataSources(subcateories, type: .subcategory)
                    if !(subcateories.count == 1 && subcateories[0] == Strings.Ad.other.localized) {
                        self?.ad.selectedSubcategory = subcateories.first ?? ""
                    }
                }
            case .failure(let error):
                print(error)
                self.loadingState = .loaded(.none)
            }
        }
    }
    
    private func prepareEditAdData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.delegate?.setTextFieldText(text: self.ad.name, type: .name)
            self.delegate?.setTextFieldText(text: self.ad.description, type: .description)
            self.delegate?.setTextFieldText(text: String(self.ad.price), type: .price)
            self.delegate?.setTextFieldText(text: String(self.ad.minRentPeriod), type: .min)
            self.delegate?.setTextFieldText(text: String(self.ad.maxRentPeriod), type: .max)
            self.delegate?.pickerViewSelectRow(row: self.categories.firstIndex(where: { $0.name == self.ad.selectedCategory }) ?? 0, type: .category)
            self.delegate?.pickerViewSelectRow(row: self.brands.firstIndex(where: { $0.name == self.ad.selectedBrand }) ?? 0, type: .brand)
            self.delegate?.pickerViewSelectRow(row: self.cities.firstIndex(where: { $0.name == self.ad.selectedCity }) ?? 0, type: .city)
            self.delegate?.updateClosedRanges(with: self.ad.closedRanges)
            self.delegate?.showMapView(with: CLLocationCoordinate2D(latitude: self.ad.location.latitude, longitude: self.ad.location.longitude), annotationTitle: self.ad.location.annotationTitle ?? "")
            self.delegate?.setTableViewHeightConstraint(type: .image, to: CGFloat(self.ad.images.count * 80) + 100)
            self.delegate?.setTableViewHeightConstraint(type: .closedRange, to: CGFloat(self.ad.closedRanges.count * 80) + 100)
            self.delegate?.updatePickerViewDataSources(self.subCategories.map { $0.name }, type: .subcategory)
            self.delegate?.pickerViewSelectRow(row: self.subCategories.firstIndex(where: { $0.name == self.ad.selectedSubcategory }) ?? 0, type: .subcategory)
            self.delegate?.layoutIfNeeded()
            self.delegate?.reloadTableView(with: .image)
            self.delegate?.reloadTableView(with: .closedRange)
        }
    }
    
    
    // MARK: - Actions
    
    func didTapCancelButton() {
        router.navigate(to: .back)
    }
    
    func didSelectRow(at index: Int, type: PickerViewType) {
        
        switch type {
        case .category:
            if index == categories.count - 1 {
                subCategories = [SubcategoryResponse(id: "0", name: Strings.Ad.other.localized)]
                ad.selectedCategory = ""
                delegate?.updatePickerViewDataSources(subCategories.map { $0.name }, type: .subcategory)
                delegate?.setPickerViewHeightConstraint(to: 175, type: .subcategory)
                delegate?.layoutIfNeeded()
                delegate?.showCustomTextFieldPickerView(type: .subcategory, animated: true, firstResponder: false)
            } else {
                fetchSubcategories(for: categories[index].id)
                delegate?.setPickerViewHeightConstraint(to: 75, type: .subcategory)
                delegate?.layoutIfNeeded()
                delegate?.hideCustomTextFieldPickerView(type: .subcategory, animated: true)
            }
            
        default:
            break
        }
        
        switch type {
        case .category:
            if index != categories.count - 1 {
                ad.selectedCategory = categories[index].name
            }
        case .subcategory:
            if index != subCategories.count - 1 {
                ad.selectedSubcategory = subCategories[index].name
            }
        case .city:
            ad.selectedCity = cities[index].name
        case .brand:
            if index != brands.count - 1 {
                ad.selectedBrand = brands[index].name
            }
        }
        
        switch type {
        case .category, .subcategory, .brand:
            let itemCount = type == .category ? categories.count : type == .subcategory ? subCategories.count : brands.count
            guard index == itemCount - 1 else {
                delegate?.setPickerViewHeightConstraint(to: 75, type: type)
                delegate?.layoutIfNeeded()
                delegate?.hideCustomTextFieldPickerView(type: type, animated: true)
                return
            }
            delegate?.setPickerViewHeightConstraint(to: 175, type: type)
            delegate?.layoutIfNeeded()
            delegate?.showCustomTextFieldPickerView(type: type, animated: true, firstResponder: true)
            switch type {
            case .category:
                ad.selectedCategory = ""
            case .brand:
                ad.selectedBrand = ""
            case .subcategory:
                ad.selectedSubcategory = ""
            default:
                break
            }
        case .city:
            break
        }
    }
    
    func textFieldDidChanged(text: String, type: TextFieldWithTitleType) {
        switch type {
        case .name:
            ad.name = text
        case .price:
            ad.price = Double(text) ?? 0
        case .description:
            ad.description = text
        }
    }
    
    func textFieldDidChanged(text: String, type: PickerViewType) {
        switch type {
        case .category:
            ad.selectedCategory = text
        case .subcategory:
            ad.selectedSubcategory = text
        case .city:
            ad.selectedCity = text
        case .brand:
            ad.selectedBrand = text
        }
    }
    
    func textFieldDidChanged(text: String, type: MinMaxItemType) {
        guard let value = Int(text) else { return }
        switch type {
        case .min:
            ad.minRentPeriod = value
        case .max:
            ad.maxRentPeriod = value
        }
    }
    
    func numberOfSections(type: AddAdTableViewTag) -> Int {
        return 1
    }
    
    func headerInSection(in section: Int, type: AddAdTableViewTag) -> Any? {
        switch type {
        case .image:
            let title = Strings.Ad.imagesHeaderTitle.localized
            let symbol = Symbols.plusCircleFill
            let buttonTitle = Strings.Ad.imagesHeaderButtonTitle.localized
            return AdImageHeaderArguments(title: title, buttonSymbol: symbol, buttonTitle: buttonTitle)
        case .closedRange:
            let title = Strings.Ad.closedRangeTitle.localized
            let symbol = Symbols.calendar
            let buttonTitle = Strings.Ad.closedRangeHeaderButtonTitle.localized
            return AdClosedRangeHeaderArguments(title: title, buttonSymbol: symbol, buttonTitle: buttonTitle)
        }
    }
    
    func heightForHeaderInSection(in section: Int, type: AddAdTableViewTag) -> CGFloat {
        return 50
    }
    
    func numberOfRows(in section: Int, type: AddAdTableViewTag) -> Int {
        switch type {
        case .image:
            ad.images.count == 0 ? 1 : ad.images.count
        case .closedRange:
            ad.closedRanges.count == 0 ? 1 : ad.closedRanges.count
        }
    }
    
    func cellForRow(at indexPath: IndexPath, type: AddAdTableViewTag) -> Any? {
        
        switch type {
        case .image:
            guard ad.images.count > 0 else {
                return AdImageCellArguments(index: 0, image: nil, imageUrl: nil, isLast: true)
            }
            
            return AdImageCellArguments(index: indexPath.row, image: ad.images[indexPath.row].image, imageUrl: ad.images[indexPath.row].imageUrl, isLast: indexPath.row == ad.images.count - 1)
        case .closedRange:
            guard ad.closedRanges.count > 0 else {
                return AdClosedRangeCellArguments(indexPath: indexPath, range: nil, isLast: true)
            }
            return AdClosedRangeCellArguments(indexPath: indexPath, range: ad.closedRanges[indexPath.row], isLast: indexPath.row == ad.closedRanges.count - 1)
        }
        
        
    }
    
    func heightForRow(at indexPath: IndexPath, type: AddAdTableViewTag) -> CGFloat {
        
        switch type {
        case .image:
            guard ad.images.count > 0 else {
                return 50
            }
            return 80
        case .closedRange:
            guard ad.closedRanges.count > 0 else {
                return 50
            }
            return 80
        }
    }
    
    func didSelectRow(at indexPath: IndexPath, type: AddAdTableViewTag) {
        
    }
    
    func didTapAddImageButton() {
        delegate?.showImagePicker()
    }
    
    func isImageSelected(identifier: String) -> Bool {
        return ad.images.contains { $0.id == identifier }
    }
    
    func sortSelectedItems(assets: [PHAsset], completion: @escaping ([PHAsset]) -> Void) {
        let sortedAssets = assets.sorted { (asset1, asset2) -> Bool in
            guard let index1 = ad.images.firstIndex(where: { $0.id == asset1.localIdentifier }),
                  let index2 = ad.images.firstIndex(where: { $0.id == asset2.localIdentifier }) else { return false }
            return index1 < index2
        }
        completion(sortedAssets)
    }
    
    func didSelectImages(assets: [PHAsset]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            addImages(assets: assets)
            delegate?.setTableViewHeightConstraint(type: .image, to: CGFloat(ad.images.count * 80) + 100)
            delegate?.layoutIfNeeded()
            delegate?.reloadTableView(with: .image)
        }
    }
    
    func didTapDeleteButton(with index: Int, type: AddAdTableViewTag) {
        switch type {
        case .image:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                ad.images.remove(at: index)
                if ad.images.count == 0 {
                    delegate?.setTableViewHeightConstraint(type: .image, to: CGFloat(100))
                } else {
                    delegate?.setTableViewHeightConstraint(type: .image, to: CGFloat(ad.images.count * 80) + 100)
                }
                delegate?.layoutIfNeeded()
                delegate?.reloadTableView(with: .image)
            }
        case .closedRange:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                ad.closedRanges.remove(at: index)
                if ad.closedRanges.count == 0 {
                    delegate?.setTableViewHeightConstraint(type: .closedRange, to: CGFloat(100))
                } else {
                    delegate?.setTableViewHeightConstraint(type: .closedRange, to: CGFloat(ad.closedRanges.count * 80) + 100)
                }
                delegate?.updateClosedRanges(with: ad.closedRanges)
                delegate?.layoutIfNeeded()
                delegate?.reloadTableView(with: .closedRange)
            }
        }
    }
    
    private func addImages(assets: [PHAsset]) {
        
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        
        assets.forEach { (asset) in
            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: options) { (image, info) in
                guard let image = image, !self.ad.images.contains(where: { $0.id == asset.localIdentifier }) else { return }
                self.ad.images.append(Image(id: asset.localIdentifier, image: image, imageUrl: nil))
            }
        }
        
        ad.images.removeAll { image in
            image.imageUrl == nil && !assets.contains(where: { $0.localIdentifier == image.id })
        }
        
    }
    
    func didTapSelectLocationButton() {
        router.navigate(to: .location(self))
    }
    
    func didTapAddClosedRangeButton() {
        delegate?.showCalendar(with: nil)
    }
    
    func didSelectCalendarValue(with value: FastisValue?) {
        guard let value = value, let range = value as? FastisRange else {
            if let editedClosedRange = editedClosedRange, let editedClosedRangeIndex = editedClosedRangeIndex {
                ad.closedRanges.insert(editedClosedRange, at: editedClosedRangeIndex)
                delegate?.updateClosedRanges(with: ad.closedRanges)
                self.editedClosedRangeIndex = nil
                self.editedClosedRange = nil
            }
            return
        }
        if let index = editedClosedRangeIndex {
            ad.closedRanges.insert(range, at: index)
            editedClosedRangeIndex = nil
            editedClosedRange = nil
        } else {
            ad.closedRanges.append(range)
        }
        delegate?.updateClosedRanges(with: ad.closedRanges)
        delegate?.setTableViewHeightConstraint(type: .closedRange, to: CGFloat(ad.closedRanges.count * 80) + 100)
        delegate?.layoutIfNeeded()
        delegate?.reloadTableView(with: .closedRange)
    }
    
    func didTapDateLabel(with indexPath: IndexPath) {
        guard indexPath.row < ad.closedRanges.count else { return }
        editedClosedRangeIndex = indexPath.row
        editedClosedRange =  ad.closedRanges[indexPath.row]
        ad.closedRanges.remove(at: indexPath.row)
        delegate?.updateClosedRanges(with: ad.closedRanges)
        delegate?.showCalendar(with: editedClosedRange)
    }
    
    func didTapAddAdButton() {
        guard validateAd() else { return }
        guard let token = authService.getAuthToken() else { return }
        ad.id = ""
        loadingState = .loading
        productService.createProduct(product: ad, token: token) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.loadingState = .loaded(.none)
                    self.notifyProductChanged()
                    self.delegate?.showAlert(
                        with: AlertMessage(
                            title: Strings.Ad.addSuccessTitle.localized,
                            message: Strings.Ad.addSuccessMessage.localized,
                            actionTitle: Strings.Common.ok.localized
                        ),
                        completion: {
                            self.router.navigate(to: .back)
                        }
                    )
                case .failure(_):
                    self.loadingState = .loaded(.none)
                    self.delegate?.showAlert(
                        with: AlertMessage(
                            title: Strings.Ad.addErrorTitle.localized,
                            message: Strings.Ad.addErrorMessage.localized,
                            actionTitle: Strings.Ad.addErrorAction.localized
                        ),
                        completion: {
                            self.router.navigate(to: .back)
                        }
                    )
                }
            }
            
        }
        
    }
    
    func didTapEditAdButton() {
        guard validateAd() else { return }
        guard let token = authService.getAuthToken() else { return }
        loadingState = .loading
        productService.updateProduct(product: ad, token: token) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.loadingState = .loaded(.none)
                    self.notifyProductChanged()
                    self.delegate?.showAlert(
                        with: AlertMessage(
                            title: Strings.Ad.updateSuccessTitle.localized,
                            message: Strings.Ad.updateSuccessMessage.localized,
                            actionTitle: Strings.Common.ok.localized
                        ),
                        completion: {
                            self.router.navigate(to: .back)
                        }
                    )
                case .failure(_):
                    self.loadingState = .loaded(.none)
                    self.delegate?.showAlert(
                        with: AlertMessage(
                            title: Strings.Ad.updateErrorTitle.localized,
                            message: Strings.Ad.updateErrorMessage.localized,
                            actionTitle: Strings.Ad.updateErrorAction.localized
                        ),
                        completion: {
                            self.router.navigate(to: .back)
                        }
                    )
                }
            }
            
        }
    }
    
    func didTapDeleteAdButton() {
        
        delegate?.showActionSheet(
            title: Strings.Ad.deleteConfirmationTitle.localized,
            message: Strings.Ad.deleteConfirmationMessage.localized,
            actionTitle: Strings.Ad.deleteConfirmationAction.localized,
            completion: { [weak self] in
                self?.deleteAd()
            }
            
        )
        
        
    }
    
    private func deleteAd() {
        guard let token = authService.getAuthToken(), let id = ad.id else { return }
        loadingState = .loading
        productService.deleteProduct(id: id, token: token) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.loadingState = .loaded(.none)
                    self.notifyProductChanged()
                    self.delegate?.showAlert(
                        with: AlertMessage(
                            title: Strings.Ad.deleteSuccessTitle.localized,
                            message: Strings.Ad.deleteSuccessMessage.localized,
                            actionTitle: Strings.Common.ok.localized
                        ),
                        completion: {
                            self.router.navigate(to: .back)
                        }
                    )
                case .failure(_):
                    self.loadingState = .loaded(.none)
                    self.delegate?.showAlert(
                        with: AlertMessage(
                            title: Strings.Ad.deleteErrorTitle.localized,
                            message: Strings.Ad.deleteErrorMessage.localized,
                            actionTitle: Strings.Common.ok.localized
                        ),
                        completion: {
                            self.router.navigate(to: .back)
                        }
                    )
                }
            }
            
        }
    }
    
    private func notifyProductChanged() {
        NotificationCenter.default.post(
            name: .changedProduct,
            object: nil,
            userInfo: [
                NotificationCenterOutputs.productId.rawValue: ad.selectedCategory,
            ]
        )
    }
    
    private func validateAd () -> Bool {
                
        if ad.selectedCategory.isEmpty {
            delegate?.showAlert(with: AlertMessage(
                title: Strings.Ad.categoryErrorTitle.localized,
                message: Strings.Ad.categoryErrorMessage.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return false
        }
        
        if ad.selectedSubcategory.isEmpty {
            delegate?.showAlert(with: AlertMessage(
                title: Strings.Ad.subcategoryErrorTitle.localized,
                message: Strings.Ad.subcategoryErrorMessage.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return false
        }
        
        if ad.selectedBrand.isEmpty {
            delegate?.showAlert(with: AlertMessage(
                title: Strings.Ad.brandErrorTitle.localized,
                message: Strings.Ad.brandErrorMessage.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return false
        }
        
        if ad.selectedCity.isEmpty {
            delegate?.showAlert(with: AlertMessage(
                title: Strings.Ad.cityErrorTitle.localized,
                message: Strings.Ad.cityErrorMessage.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return false
        }
        
        if ad.name.count < 10 {
            delegate?.showAlert(with: AlertMessage(
                title: Strings.Ad.nameErrorTitle.localized,
                message: Strings.Ad.nameErrorMessage.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return false
        }
        
        if ad.price == 0 || ad.price < 0 {
            delegate?.showAlert(with: AlertMessage(
                title: Strings.Ad.priceErrorTitle.localized,
                message: Strings.Ad.priceErrorMessage.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return false
        }
        
        if ad.description.count < 20 {
            delegate?.showAlert(with: AlertMessage(
                title: Strings.Ad.descriptionErrorTitle.localized,
                message: Strings.Ad.descriptionErrorMessage.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return false
        }
        
        if ad.minRentPeriod == 0 || ad.minRentPeriod < 0 {
            delegate?.showAlert(with: AlertMessage(
                title: Strings.Ad.minRentPeriodErrorTitle.localized,
                message: Strings.Ad.minRentPeriodErrorMessage.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return false
        }
        
        if ad.maxRentPeriod == 0 || ad.maxRentPeriod < 0 {
            delegate?.showAlert(with: AlertMessage(
                title: Strings.Ad.maxRentPeriodErrorTitle.localized,
                message: Strings.Ad.maxRentPeriodErrorMessage.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return false
        }
        
        if ad.minRentPeriod > ad.maxRentPeriod {
            delegate?.showAlert(with: AlertMessage(
                title: Strings.Ad.minMaxRentPeriodErrorTitle.localized,
                message: Strings.Ad.minMaxRentPeriodErrorMessage.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return false
        }
        
        if ad.images.count <= 0 {
            delegate?.showAlert(with: AlertMessage(
                title: Strings.Ad.imageErrorTitle.localized,
                message: Strings.Ad.imageErrorMessage.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return false
        }
        
        if ad.location.latitude == 0 || ad.location.longitude == 0 {
            delegate?.showAlert(with: AlertMessage(
                title: Strings.Ad.locationNotFoundErrorTitle.localized,
                message: Strings.Ad.locationNotFoundErrorTitle.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return false
        }
        
        if ad.location.latitude > 90 || ad.location.latitude < -90 && ad.location.longitude > 180 && ad.location.longitude < -180  {
            delegate?.showAlert(with: AlertMessage(
                title: Strings.Ad.locationErrorTitle.localized,
                message: Strings.Ad.locationErrorMessage.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return false
        }
        
        return true
        
        
    }
    
}

extension AddAdViewModel: SelectLocationDelegate {
    
    func didSelectLocation(coordinate: CLLocationCoordinate2D, address: String) {
        ad.location = Location(latitude: coordinate.latitude, longitude: coordinate.longitude, annotationTitle: address)
        delegate?.showMapView(with: coordinate, annotationTitle: address)
    }
    
}
