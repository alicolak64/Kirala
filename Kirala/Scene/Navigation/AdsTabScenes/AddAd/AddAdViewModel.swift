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
    let image: UIImage
}


final class AddAdViewModel {
    
    // MARK: - Dependency Properties
    
    weak var delegate: AddAdViewProtocol?
    
    private let router: AddAdRouterProtocol
    private let authService: AuthService
    private let categoryService: CategoryService
    private let authenticationService: AuthenticationService
    private let editArguments: EditAddAdArguments?
    
    private var categories = Category.otherWithMockCategories.map { $0.name }
    private var subCategories = Subcategory.otherWithMockSubcategories.map { $0.name }
    private var cities = SearchablePopupArguments.getCityMockData().items.map { $0.name }
    private var brands = SearchablePopupArguments.getBrandMockData().items.map { $0.name }
    private var selectedImages = [Image]()
    private var selectedClosedRanges = [FastisRange]()
    private var editedClosedRangeIndex: Int?
    private var editedClosedRange: FastisRange?
    
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
        
    // MARK: - Initializers
    
    init(router: AddAdRouterProtocol, dependencies: [DependencyType: Any]) {
        self.router = router
        self.authService = dependencies[.authService] as! AuthService
        self.categoryService = dependencies[.categoryService] as! CategoryService
        self.authenticationService = dependencies[.authenticationService] as! AuthenticationService
        self.editArguments = nil
    }
    
    init(router: AddAdRouterProtocol, arguments: EditAddAdArguments, dependencies: [DependencyType: Any]) {
        self.router = router
        self.authService = dependencies[.authService] as! AuthService
        self.categoryService = dependencies[.categoryService] as! CategoryService
        self.authenticationService = dependencies[.authenticationService] as! AuthenticationService
        self.editArguments = arguments
    }
    
}

extension AddAdViewModel: AddAdViewModelProtocol {
    
    // MARK: - Lifecycle Methods
    
    func viewDidLoad() {
        
        delegate?.prepareUI()
        delegate?.prepareConstraints()
        
        if let editArguments = editArguments {
            delegate?.prepareNavigationBar(title: Strings.Ad.updateAd.localized)
            delegate?.prepareEditAdFooter()
        } else {
            delegate?.prepareNavigationBar(title: Strings.Ad.addAd.localized)
            delegate?.prepareAddAdFooter()
        }
        
        delegate?.prepareCategoryPickerView(with: categories)
        delegate?.prepareSubcategoryPickerView(with: subCategories)
        delegate?.prepareBrandPickerView(with: brands)
        delegate?.prepareCityPickerView(with: cities)
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
            closedRanges: selectedClosedRanges
        )
        
        
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
    
    // MARK: - Actions
    
    func didTapCancelButton() {
        router.navigate(to: .back)
    }
    
    func didSelectRow(at index: Int, type: PickerViewType) {
        switch type {
        case .category, .subcategory, .brand:
            let items = type == .category ? categories : type == .subcategory ? subCategories : brands
            guard index == items.count - 1 else {
                delegate?.setPickerViewHeightConstraint(to: 75, type: type)
                delegate?.layoutIfNeeded()
                delegate?.hideCustomTextFieldPickerView(type: type, animated: true)
                return
            }
            delegate?.setPickerViewHeightConstraint(to: 160, type: type)
            delegate?.layoutIfNeeded()
            delegate?.showCustomTextFieldPickerView(type: type, animated: true, firstResponder: true)
        case .city:
            break
        }
    }
    
    func textFieldDidChanged(text: String, type: TextFieldWithTitleType) {
        print(text)
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
            selectedImages.count == 0 ? 1 : selectedImages.count
        case .closedRange:
            selectedClosedRanges.count == 0 ? 1 : selectedClosedRanges.count
        }
    }
    
    func cellForRow(at indexPath: IndexPath, type: AddAdTableViewTag) -> Any? {
        
        switch type {
        case .image:
            guard selectedImages.count > 0 else {
                return AdImageCellArguments(index: 0, image: nil, imageUrl: nil, isLast: true)
            }
                    
            return AdImageCellArguments(index: indexPath.row, image: selectedImages[indexPath.row].image, imageUrl: nil, isLast: indexPath.row == selectedImages.count - 1)
        case .closedRange:
            guard selectedClosedRanges.count > 0 else {
                return AdClosedRangeCellArguments(indexPath: indexPath, range: nil, isLast: true)
            }
            return AdClosedRangeCellArguments(indexPath: indexPath, range: selectedClosedRanges[indexPath.row], isLast: indexPath.row == selectedClosedRanges.count - 1)
        }
        
        
    }
    
    func heightForRow(at indexPath: IndexPath, type: AddAdTableViewTag) -> CGFloat {
        
        switch type {
        case .image:
            guard selectedImages.count > 0 else {
               return 50
            }
            return 80
        case .closedRange:
            guard selectedClosedRanges.count > 0 else {
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
        return selectedImages.contains { $0.id == identifier }
    }
    
    func sortSelectedItems(assets: [PHAsset], completion: @escaping ([PHAsset]) -> Void) {
        let sortedAssets = assets.sorted { (asset1, asset2) -> Bool in
            guard let index1 = selectedImages.firstIndex(where: { $0.id == asset1.localIdentifier }),
                  let index2 = selectedImages.firstIndex(where: { $0.id == asset2.localIdentifier }) else { return false }
            return index1 < index2
        }
        completion(sortedAssets)
    }
    
    func didSelectImages(assets: [PHAsset]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            addImages(assets: assets)
            delegate?.setTableViewHeightConstraint(type: .image, to: CGFloat(selectedImages.count * 80) + 100)
            delegate?.layoutIfNeeded()
            delegate?.reloadTableView(with: .image)
        }
    }
    
    func didTapDeleteButton(with index: Int, type: AddAdTableViewTag) {
        switch type {
        case .image:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                selectedImages.remove(at: index)
                if selectedImages.count == 0 {
                    delegate?.setTableViewHeightConstraint(type: .image, to: CGFloat(100))
                } else {
                    delegate?.setTableViewHeightConstraint(type: .image, to: CGFloat(selectedImages.count * 80) + 100)
                }
                delegate?.layoutIfNeeded()
                delegate?.reloadTableView(with: .image)
            }
        case .closedRange:
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                selectedClosedRanges.remove(at: index)
                if selectedClosedRanges.count == 0 {
                    delegate?.setTableViewHeightConstraint(type: .closedRange, to: CGFloat(100))
                } else {
                    delegate?.setTableViewHeightConstraint(type: .closedRange, to: CGFloat(selectedClosedRanges.count * 80) + 100)
                }
                delegate?.updateClosedRanges(with: selectedClosedRanges)
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
                guard let image = image, !self.selectedImages.contains(where: { $0.id == asset.localIdentifier }) else { return }
                self.selectedImages.append(Image(id: asset.localIdentifier, image: image))
            }
        }
        
        selectedImages.removeAll { (image) -> Bool in
            !assets.contains(where: { $0.localIdentifier == image.id })
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
                selectedClosedRanges.insert(editedClosedRange, at: editedClosedRangeIndex)
                delegate?.updateClosedRanges(with: selectedClosedRanges)
                self.editedClosedRangeIndex = nil
                self.editedClosedRange = nil
            }
            return
        }
        if let index = editedClosedRangeIndex {
            selectedClosedRanges.insert(range, at: index)
            editedClosedRangeIndex = nil
            editedClosedRange = nil
        } else {
            selectedClosedRanges.append(range)
        }
        delegate?.updateClosedRanges(with: selectedClosedRanges)
        delegate?.setTableViewHeightConstraint(type: .closedRange, to: CGFloat(selectedClosedRanges.count * 80) + 100)
        delegate?.layoutIfNeeded()
        delegate?.reloadTableView(with: .closedRange)
    }
    
    func didTapDateLabel(with indexPath: IndexPath) {
        guard indexPath.row < selectedClosedRanges.count else { return }
        editedClosedRangeIndex = indexPath.row
        editedClosedRange =  selectedClosedRanges[indexPath.row]
        selectedClosedRanges.remove(at: indexPath.row)
        delegate?.updateClosedRanges(with: selectedClosedRanges)
        delegate?.showCalendar(with: editedClosedRange)
    }
    
}

extension AddAdViewModel: SelectLocationDelegate {
    
    func didSelectLocation(coordinate: CLLocationCoordinate2D, address: String) {
        delegate?.showMapView(with: coordinate, annotationTitle: address)
    }
    
}
