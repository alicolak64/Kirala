//
//  AddAdViewController.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import UIKit
import Photos
import BSImagePicker
import MapKit


final class AddAdViewController: UIViewController, SwipePerformable, BackNavigatable {
    
    // MARK: - Properties
    private let viewModel: AddAdViewModel
    
    // MARK: - UI Properties
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var categoryPickerView: PickerView = {
        let pickerView = PickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private lazy var subcategoryPickerView: PickerView = {
        let pickerView = PickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private lazy var brandPickerView: PickerView = {
        let pickerView = PickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private lazy var cityPickerView: PickerView = {
        let pickerView = PickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private lazy var nameTextField: TextFieldWithTitle = {
        let textField = TextFieldWithTitle()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var priceTextField: TextFieldWithTitle = {
        let textField = TextFieldWithTitle()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var descriptionTextField: TextFieldWithTitle = {
        let textField = TextFieldWithTitle()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var imagesTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.tag = AddAdTableViewTag.image.rawValue
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var closedRangesTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.tag = AddAdTableViewTag.closedRange.rawValue
        tableView.bounces = false
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
    
    private lazy var locationSelectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorBackground.primary.dynamicColor
        return view
    }()
    
    private lazy var locationTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = Strings.Ad.locationTitle.localized
        label.textColor = ColorText.primary.dynamicColor
        return label
    }()
    
    private lazy var locationPlaceholderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = Strings.Ad.locationPlaceholder.localized
        label.textColor = ColorText.quaternary.dynamicColor
        return label
    }()
    
    private lazy var selecLocationButton: UIButton = {
        let button = UIButton(type: .system)
        
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .leading
        config.imagePadding = 10
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var attributes = attributes
            attributes.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            attributes.foregroundColor = ColorText.primary.dynamicColor
            return attributes
        }
        
        config.title = Strings.Ad.selectLocation.localized
        config.image = Symbols.locationFill.symbol(size: 12, weight: .regular)
        
        button.configuration = config
        button.tintColor = ColorPalette.appPrimary.dynamicColor
        button.backgroundColor = ColorBackground.primary.dynamicColor
        button.addTarget(self, action: #selector(didTapSelectLocationButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    
    private lazy var rentalPeriodSelectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorBackground.primary.dynamicColor
        return view
    }()
    
    private lazy var rentalPeriodTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.text = Strings.Ad.rentalPeriodTitle.localized
        label.textColor = ColorText.primary.dynamicColor
        return label
    }()
    
    private lazy var rentalPeriodTipLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.text = Strings.Ad.rentalPeriodTip.localized
        label.textColor = ColorText.secondary.dynamicColor
        return label
    }()
    
    private lazy var minMaxView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorBackground.primary.dynamicColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var minTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.Filter.min.localized
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addBorder(width: 1, color: ColorPalette.border.dynamicColor)
        textField.addCornerRadius(radius: 10)
        textField.tag = MinMaxItemType.min.rawValue
        textField.delegate = self
        textField.addTarget(self, action: #selector(minTextFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var minMaxSeparator: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = ColorPalette.border.dynamicColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var maxTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Strings.Filter.max.localized
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addBorder(width: 1, color: ColorPalette.border.dynamicColor)
        textField.addCornerRadius(radius: 10)
        textField.tag = MinMaxItemType.max.rawValue
        textField.addTarget(self, action: #selector(maxTextFieldDidChange), for: .editingChanged)
        textField.delegate = self
        return textField
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.makeFooterStyle()
        return view
    }()
    
    private lazy var addAdButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.Ad.addAd.localized, for: .normal)
        button.tintColor = ColorText.primary.dynamicColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = ColorPalette.appPrimary.dynamicColor
        button.addCornerRadius(radius: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapAdAddButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var editAdButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.Ad.updateAd.localized, for: .normal)
        button.tintColor = ColorText.primary.dynamicColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = ColorPalette.appPrimary.dynamicColor
        button.addCornerRadius(radius: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapAdEditButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteAdButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.Ad.deleteAd.localized, for: .normal)
        button.tintColor = ColorText.primary.dynamicColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = ColorPalette.gray.dynamicColor
        button.addCornerRadius(radius: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapAdDeleteButton), for: .touchUpInside)
        return button
    }()
    
    
    private var categoryHeightConstraint: NSLayoutConstraint?
    private var subcategoryHeightConstraint: NSLayoutConstraint?
    private var brandHeightConstraint: NSLayoutConstraint?
    private var cityHeightConstraint: NSLayoutConstraint?
    private var imagesTableViewHeightConstraint: NSLayoutConstraint?
    private var closedRangesTableViewHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Initializers
    init(viewModel: AddAdViewModel) {
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
    
    func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func backButtonTapped() {
        viewModel.didTapCancelButton()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func didTapAdAddButton() {
        viewModel.didTapAddAdButton()
    }
    
    @objc func didTapAdEditButton() {
        viewModel.didTapEditAdButton()
    }
    
    @objc func didTapAdDeleteButton() {
        viewModel.didTapDeleteAdButton()
    }
    
    @objc func didTapSelectLocationButton() {
        viewModel.didTapSelectLocationButton()
    }
    
    @objc func minTextFieldDidChange(_ textField: UITextField) {
        viewModel.textFieldDidChanged(text: textField.text ?? "", type: .min)
    }
    
    @objc func maxTextFieldDidChange(_ textField: UITextField) {
        viewModel.textFieldDidChanged(text: textField.text ?? "", type: .max)
    }
    
}

extension AddAdViewController: AddAdViewProtocol {
    
    
    func setTextFieldText(text: String, type: TextFieldWithTitleType) {
        switch type {
        case .name:
            nameTextField.setTextFieldText(text)
        case .price:
            priceTextField.setTextFieldText(text)
        case .description:
            descriptionTextField.setTextViewText(text)
        }
    }
    
    func setTextFieldText(text: String, type: MinMaxItemType) {
        switch type {
        case .min:
            minTextField.text = text
        case .max:
            maxTextField.text = text
        }
    }
    
    func pickerViewSelectRow(row: Int, type: PickerViewType) {
        switch type {
        case .category:
            categoryPickerView.setPickerViewSelectedRow(at: row)
        case .subcategory:
            subcategoryPickerView.setPickerViewSelectedRow(at: row)
        case .brand:
            brandPickerView.setPickerViewSelectedRow(at: row)
        case .city:
            cityPickerView.setPickerViewSelectedRow(at: row)
        }
    }
    
    func showLoading() {
        loadingView.showLoading()
    }
    
    func hideLoading(loadResult: LoadingResult) {
        loadingView.hideLoading(loadResult: loadResult)
    }
    
    func updatePickerViewDataSources(_ items: [String], type: PickerViewType) {
        switch type {
        case .category:
            categoryPickerView.updateItems(items)
        case .subcategory:
            subcategoryPickerView.updateItems(items)
        case .brand:
            brandPickerView.updateItems(items)
        case .city:
            cityPickerView.updateItems(items)
        }
    }
    
    func showImagePicker() {
        
        let allAssets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
        var selectedAssets = [PHAsset]()
        
        allAssets.enumerateObjects({ [weak self] (asset, idx, stop) -> Void in
            if (self?.viewModel.isImageSelected(identifier: asset.localIdentifier) ?? false) {
                selectedAssets.append(asset)
            }
        })
        
        viewModel.sortSelectedItems(assets: selectedAssets, completion: {  (sortedAssets) in
            selectedAssets = sortedAssets
        })
        
        let imagePicker = ImagePickerController(selectedAssets: selectedAssets)
        imagePicker.settings.selection.max = 10
        imagePicker.settings.theme.selectionStyle = .numbered
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        imagePicker.settings.selection.unselectOnReachingMax = true
        var allAlbums: [PHFetchResult<PHAssetCollection>] = []
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
        allAlbums.append(smartAlbums)
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
        allAlbums.append(userAlbums)
        imagePicker.settings.fetch.album.fetchResults = allAlbums

        self.presentImagePicker(imagePicker,
        select: { (asset) in
        }, deselect: { (asset) in
        }, cancel: { (assets) in
        }, finish: { [weak self] (assets) in
            self?.viewModel.didSelectImages(assets: assets)
        }, completion: {
            
        })
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
                self?.calendar.setClearCurrentValue()
            case .cancel:
                self?.calendar.setClearCurrentValue()
                self?.viewModel.didSelectCalendarValue(with: nil)
            }
        }
    }
    
    func showCalendar(with value: FastisValue?) {
        calendar.initialValue = value as? FastisRange
        calendar.present(above: self)
    }
    
    func updateClosedRanges(with ranges: [FastisRange]) {
        calendar.closedRanges = ranges
    }
    
    func prepareNavigationBar(title: String) {
        navigationItem.hidesBackButton = true
        addBackButton()
        addBottomBorder()
        navigationItem.title = title
    }
    
    func prepareUI() {
        view.backgroundColor = ColorBackground.primary.dynamicColor
        
        view.addSubviews([
            scrollView,
            footerView,
            loadingView
        ])
        
        scrollView.addSubview(verticalStackView)
        
        locationSelectView.addSubviews([
            locationTitleLabel,
            selecLocationButton,
            locationPlaceholderLabel
        ])
        
        verticalStackView.addArrangedSubviews([
            categoryPickerView,
            subcategoryPickerView,
            brandPickerView,
            nameTextField,
            cityPickerView,
            priceTextField,
            descriptionTextField,
            rentalPeriodSelectView,
            locationSelectView,
            mapView,
            imagesTableView,
            closedRangesTableView
        ])
        
    }
    
    func prepareConstraints() {
        categoryHeightConstraint = categoryPickerView.heightAnchor.constraint(equalToConstant: 75)
        subcategoryHeightConstraint = subcategoryPickerView.heightAnchor.constraint(equalToConstant: 75)
        brandHeightConstraint = brandPickerView.heightAnchor.constraint(equalToConstant: 75)
        cityHeightConstraint = cityPickerView.heightAnchor.constraint(equalToConstant: 75)
        imagesTableViewHeightConstraint = imagesTableView.heightAnchor.constraint(equalToConstant: 100)
        closedRangesTableViewHeightConstraint = closedRangesTableView.heightAnchor.constraint(equalToConstant: 100)
        
        categoryHeightConstraint?.isActive = true
        subcategoryHeightConstraint?.isActive = true
        brandHeightConstraint?.isActive = true
        cityHeightConstraint?.isActive = true
        imagesTableViewHeightConstraint?.isActive = true
        closedRangesTableViewHeightConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 80),
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
            verticalStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            verticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            verticalStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
                
        NSLayoutConstraint.activate([
            locationTitleLabel.leadingAnchor.constraint(equalTo: locationSelectView.leadingAnchor),
            locationTitleLabel.centerYAnchor.constraint(equalTo: locationSelectView.centerYAnchor),
            
            selecLocationButton.trailingAnchor.constraint(equalTo: locationSelectView.trailingAnchor),
            selecLocationButton.centerYAnchor.constraint(equalTo: locationSelectView.centerYAnchor),
            
            locationPlaceholderLabel.leadingAnchor.constraint(equalTo: locationSelectView.leadingAnchor),
            locationPlaceholderLabel.topAnchor.constraint(equalTo: locationSelectView.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.heightAnchor.constraint(equalToConstant: 80),
            priceTextField.heightAnchor.constraint(equalToConstant: 80),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 137),
            locationSelectView.heightAnchor.constraint(equalToConstant: 40),
            rentalPeriodSelectView.heightAnchor.constraint(equalToConstant: 100),
            mapView.heightAnchor.constraint(equalToConstant: 300),
        ])
        
    }
    
    func prepareCategoryPickerView(with categories: [String]) {
        let presenter = PickerViewPresenter(
            view: categoryPickerView,
            arguments: PickerViewArguments(
                pickerViewTitle: Strings.Ad.categoryTitle.localized,
                pickerViewPlaceholder: Strings.Ad.categoryPlaceholder.localized,
                pickerViewTip: Strings.Ad.categoryTip.localized,
                customTextFieldTitle: Strings.Ad.customCategoryTitle.localized,
                customTextFieldPlaceholder: Strings.Ad.customCategoryPlaceholder.localized,
                customTextFieldTip: Strings.Ad.customCategoryTip.localized,
                items: categories,
                selectedItem: nil,
                customTextFieldArguments: nil,
                pickerViewType: .category
            )
        )
        
        presenter.delegate = self
        categoryPickerView.presenter = presenter
    }
    
    func prepareSubcategoryPickerView(with subcategories: [String]) {
        let presenter = PickerViewPresenter(
            view: subcategoryPickerView,
            arguments: PickerViewArguments(
                pickerViewTitle: Strings.Ad.subCategoryTitle.localized,
                pickerViewPlaceholder: Strings.Ad.subCategoryPlaceholder.localized,
                pickerViewTip: Strings.Ad.subCategoryTip.localized,
                customTextFieldTitle: Strings.Ad.customSubCategoryTitle.localized,
                customTextFieldPlaceholder: Strings.Ad.customSubCategoryPlaceholder.localized,
                customTextFieldTip: Strings.Ad.customSubCategoryTip.localized,
                items: subcategories,
                selectedItem: nil,
                customTextFieldArguments: nil,
                pickerViewType: .subcategory
            )
        )
        presenter.delegate = self
        subcategoryPickerView.presenter = presenter
    }
    
    func prepareBrandPickerView(with brands: [String]) {
        let presenter = PickerViewPresenter(
            view: brandPickerView,
            arguments: PickerViewArguments(
                pickerViewTitle: Strings.Ad.brandTitle.localized,
                pickerViewPlaceholder: Strings.Ad.brandPlaceholder.localized,
                pickerViewTip: Strings.Ad.brandTip.localized,
                customTextFieldTitle: Strings.Ad.customBrandTitle.localized,
                customTextFieldPlaceholder: Strings.Ad.customBrandPlaceholder.localized,
                customTextFieldTip: Strings.Ad.customBrandTip.localized,
                items: brands,
                selectedItem: nil,
                customTextFieldArguments: nil,
                pickerViewType: .brand
            )
        )
        presenter.delegate = self
        brandPickerView.presenter = presenter
    }
    
    func prepareCityPickerView(with cities: [String]) {
        let presenter = PickerViewPresenter(
            view: cityPickerView,
            arguments: PickerViewArguments(
                pickerViewTitle: Strings.Ad.cityTitle.localized,
                pickerViewPlaceholder: Strings.Ad.cityPlaceholder.localized,
                pickerViewTip: Strings.Ad.cityTip.localized,
                customTextFieldTitle: "",
                customTextFieldPlaceholder: "",
                customTextFieldTip: "",
                items: cities,
                selectedItem: nil,
                customTextFieldArguments: nil,
                pickerViewType: .city
            )
        )
        presenter.delegate = self
        cityPickerView.presenter = presenter
    }
    
    func prepareNameTextField() {
        let presenter = TextFieldWithTitlePresenter(
            view: nameTextField,
            arguments: TextFieldWithTitleViewArguments(
                title: Strings.Ad.nameTitle.localized,
                placeholder: Strings.Ad.namePlaceholder.localized,
                tip: Strings.Ad.nameTip.localized,
                text: nil,
                type: .name
            )
        )
        presenter.delegate = self
        nameTextField.presenter = presenter
    }
    
    func preparePriceTextField() {
        let presenter = TextFieldWithTitlePresenter(
            view: priceTextField,
            arguments: TextFieldWithTitleViewArguments(
                title: Strings.Ad.priceTitle.localized,
                placeholder: Strings.Ad.pricePlaceholder.localized,
                tip: Strings.Ad.priceTip.localized,
                text: nil,
                type: .price
            )
        )
        presenter.delegate = self
        priceTextField.presenter = presenter
    }
    
    func prepareDescriptionTextField() {
        let presenter = TextFieldWithTitlePresenter(
            view: descriptionTextField,
            arguments: TextFieldWithTitleViewArguments(
                title: Strings.Ad.descriptionTitle.localized,
                placeholder: Strings.Ad.descriptionPlaceholder.localized,
                tip: Strings.Ad.descriptionTip.localized,
                text: nil,
                type: .description
            )
        )
        presenter.delegate = self
        descriptionTextField.presenter = presenter
    }
    
    func prepareImagesTableView() {
        imagesTableView.delegate = self
        imagesTableView.dataSource = self
        imagesTableView.registerHeader(AdImageHeaderCell.self)
        imagesTableView.register(AdImageCell.self)
    }
    
    func prepareClosedRangeTableView() {
        closedRangesTableView.delegate = self
        closedRangesTableView.dataSource = self
        closedRangesTableView.registerHeader(AdClosedRangeHeaderCell.self)
        closedRangesTableView.register(AdClosedRangeCell.self)
    }
    
    func prepareMinMaxPeriodTextField() {
        minMaxView.addSubviews([
            minTextField,
            minMaxSeparator,
            maxTextField
        ])
        
        rentalPeriodSelectView.addSubviews([
            rentalPeriodTitleLabel,
            minMaxView,
            rentalPeriodTipLabel
        ])
                
        NSLayoutConstraint.activate([
            rentalPeriodTitleLabel.leadingAnchor.constraint(equalTo: rentalPeriodSelectView.leadingAnchor),
            rentalPeriodTitleLabel.topAnchor.constraint(equalTo: rentalPeriodSelectView.topAnchor),
            
            minMaxView.topAnchor.constraint(equalTo: rentalPeriodTitleLabel.bottomAnchor, constant: 10),
            minMaxView.leadingAnchor.constraint(equalTo: rentalPeriodSelectView.leadingAnchor),
            minMaxView.trailingAnchor.constraint(equalTo: rentalPeriodSelectView.trailingAnchor),
            minMaxView.heightAnchor.constraint(equalToConstant: 60),
            
            minTextField.leadingAnchor.constraint(equalTo: minMaxView.leadingAnchor, constant: 10),
            minTextField.widthAnchor.constraint(equalTo: minMaxView.widthAnchor, multiplier: 0.435),
            minTextField.topAnchor.constraint(equalTo: minMaxView.topAnchor, constant: 10),
            minTextField.bottomAnchor.constraint(equalTo: minMaxView.bottomAnchor, constant: -10),
            
            minMaxSeparator.leadingAnchor.constraint(equalTo: minTextField.trailingAnchor, constant: 10),
            minMaxSeparator.centerYAnchor.constraint(equalTo: minMaxView.centerYAnchor),
            
            maxTextField.leadingAnchor.constraint(equalTo: minMaxSeparator.trailingAnchor, constant: 10),
            maxTextField.widthAnchor.constraint(equalTo: minMaxView.widthAnchor, multiplier: 0.435),
            maxTextField.topAnchor.constraint(equalTo: minMaxView.topAnchor, constant: 10),
            maxTextField.bottomAnchor.constraint(equalTo: minMaxView.bottomAnchor, constant: -10),
            
            rentalPeriodTipLabel.leadingAnchor.constraint(equalTo: rentalPeriodSelectView.leadingAnchor),
            rentalPeriodTipLabel.topAnchor.constraint(equalTo: minMaxView.bottomAnchor),
            rentalPeriodTipLabel.bottomAnchor.constraint(equalTo: rentalPeriodSelectView.bottomAnchor),
        ])
        
    }
    
    func layoutIfNeeded() {
        view.layoutIfNeeded()
    }
    
    func setPickerViewHeightConstraint(to constant: CGFloat, type: PickerViewType) {
        switch type {
        case .category:
            categoryHeightConstraint?.constant = constant
        case .subcategory:
            subcategoryHeightConstraint?.constant = constant
        case .brand:
            brandHeightConstraint?.constant = constant
        case .city:
            cityHeightConstraint?.constant = constant
        }
    }
    
    func showCustomTextFieldPickerView(type: PickerViewType, animated: Bool, firstResponder: Bool) {
        switch type {
        case .category:
            categoryPickerView.showCustomTextField(animated: animated, firstResponder: firstResponder)
        case .subcategory:
            subcategoryPickerView.showCustomTextField(animated: animated, firstResponder: firstResponder)
        case .brand:
            brandPickerView.showCustomTextField(animated: animated, firstResponder: firstResponder)
        case .city:
            cityPickerView.showCustomTextField(animated: animated, firstResponder: firstResponder)
        }
    }
    
    func hideCustomTextFieldPickerView(type: PickerViewType, animated: Bool) {
        switch type {
        case .category:
            categoryPickerView.hideCustomTextField(animated: animated)
        case .subcategory:
            subcategoryPickerView.hideCustomTextField(animated: animated)
        case .brand:
            brandPickerView.hideCustomTextField(animated: animated)
        case .city:
            cityPickerView.hideCustomTextField(animated: animated)
        }
    }
    
    func setTableViewHeightConstraint(type: AddAdTableViewTag, to constant: CGFloat) {
        switch type {
        case .image:
            imagesTableViewHeightConstraint?.constant = constant
            view.layoutIfNeeded()
        case .closedRange:
            closedRangesTableViewHeightConstraint?.constant = constant
            view.layoutIfNeeded()
        }
    }
    
    func prepareAddAdFooter() {
        footerView.addSubview(addAdButton)
        NSLayoutConstraint.activate([
            addAdButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            addAdButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            addAdButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            addAdButton.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    func prepareEditAdFooter() {
        
        footerView.addSubviews([
            editAdButton,
            deleteAdButton
        ])
        
        NSLayoutConstraint.activate([
            deleteAdButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            deleteAdButton.trailingAnchor.constraint(equalTo: footerView.centerXAnchor, constant: -10),
            deleteAdButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            deleteAdButton.heightAnchor.constraint(equalToConstant: 40),
            
            editAdButton.leadingAnchor.constraint(equalTo: footerView.centerXAnchor, constant: 10),
            editAdButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            editAdButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor),
            editAdButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func getCollectionViewType(from tag: Int?) -> AddAdTableViewTag {
        guard let tag = tag else { return .image }
        return AddAdTableViewTag(rawValue: tag) ?? .image
    }
    
}

extension AddAdViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections(type: getCollectionViewType(from: tableView.tag))
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let arguments = viewModel.headerInSection(in: section, type: getCollectionViewType(from: tableView.tag)) else { return nil }
        
        switch getCollectionViewType(from: tableView.tag) {
        case .image:
            let cell: AdImageHeaderCell = tableView.dequeueReusableHeader()
            let presenter = AdImageHeaderCellPresenter(
                view: cell,
                arguments: arguments as! AdImageHeaderArguments
            )
            presenter.delegate = self
            cell.presenter = presenter
            return cell
        case .closedRange:
            let cell: AdClosedRangeHeaderCell = tableView.dequeueReusableHeader()
            let presenter = AdClosedRangeHeaderCellPresenter(
                view: cell,
                arguments: arguments as! AdClosedRangeHeaderArguments
            )
            presenter.delegate = self
            cell.presenter = presenter
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        viewModel.heightForHeaderInSection(in: section, type: getCollectionViewType(from: tableView.tag))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section, type: getCollectionViewType(from: tableView.tag))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let arguments = viewModel.cellForRow(at: indexPath, type: getCollectionViewType(from: tableView.tag)) else { return UITableViewCell() }
        
        switch getCollectionViewType(from: tableView.tag) {
        case .image:
            guard arguments is AdImageCellArguments else { return UITableViewCell() }
            let cell: AdImageCell = tableView.dequeueReusableCell()
            let presenter = AdImageCellPresenter(
                view: cell,
                arguments: arguments as! AdImageCellArguments
            )
            presenter.delegate = self
            cell.presenter = presenter
            return cell
        case .closedRange:
            guard arguments is AdClosedRangeCellArguments else { return UITableViewCell() }
            let cell: AdClosedRangeCell = tableView.dequeueReusableCell()
            let presenter = AdClosedRangeCellPresenter(
                view: cell,
                arguments: arguments as! AdClosedRangeCellArguments
            )
            presenter.delegate = self
            cell.presenter = presenter
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRow(at: indexPath, type: getCollectionViewType(from: tableView.tag))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath, type: getCollectionViewType(from: tableView.tag))
    }
    
    func reloadTableView(with type: AddAdTableViewTag) {
        switch type {
        case .image:
            imagesTableView.reloadData()
        case .closedRange:
            closedRangesTableView.reloadData()
        }
    }
    
    func reloadItems(at indexPaths: [IndexPath], type: AddAdTableViewTag) {
        switch type {
        case .image:
            imagesTableView.reloadRows(at: indexPaths, with: .automatic)
        case .closedRange:
            closedRangesTableView.reloadRows(at: indexPaths, with: .automatic)
        }
    }
    
    func deleteItems(at indexPaths: [IndexPath], type: AddAdTableViewTag) {
        switch type {
        case .image:
            imagesTableView.deleteRows(at: indexPaths, with: .automatic)
        case .closedRange:
            closedRangesTableView.deleteRows(at: indexPaths, with: .automatic)
        }
    }
    
    func showMapView(with cgLocation: CLLocationCoordinate2D, annotationTitle: String) {
        mapView.isHidden = false
        locationPlaceholderLabel.isHidden = true
        mapView.setRegion(MKCoordinateRegion(center: cgLocation, latitudinalMeters: 1000, longitudinalMeters: 1000), animated: true)
        
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = cgLocation
        annotation.title = annotationTitle
        mapView.addAnnotation(annotation)
    }
    
    
}

extension AddAdViewController: PickerViewDelegate {
    
    func didSelectRow(at index: Int, pickerViewType: PickerViewType) {
        viewModel.didSelectRow(at: index, type: pickerViewType)
    }
    
    func customTextFieldTextDidChanged(_ text: String, pickerViewType: PickerViewType) {
        viewModel.textFieldDidChanged(text: text, type: pickerViewType)
    }
    
}

extension AddAdViewController: TextFieldWithTitleDelegate {
    
    func textFieldDidChanged(_ text: String, type: TextFieldWithTitleType) {
        viewModel.textFieldDidChanged(text: text, type: type)
    }
    
}

extension AddAdViewController: AdImageHeaderCellDelegate {
    
    func didTapAddImageButton() {
        viewModel.didTapAddImageButton()
    }
    
}

extension AddAdViewController: AdImageCellDelegate {
    
    func didTapDeleteButton(with index: Int) {
        viewModel.didTapDeleteButton(with: index, type: .image)
    }
    
}

extension AddAdViewController: AdClosedRangeHeaderCellDelegate {
    
    func didTapAddClosedRangeButton() {
       viewModel.didTapAddClosedRangeButton()
    }
    
}

extension AddAdViewController: AdClosedRangeCellDelegate {
    
    
    func didTapDeleteButton(with indexPath: IndexPath) {
        viewModel.didTapDeleteButton(with: indexPath.row, type: .closedRange)
    }
    
    func didTapDateLabel(with indexPath: IndexPath) {
        viewModel.didTapDateLabel(with: indexPath)
    }
    
}

extension AuthViewController: Alertable, ActionSheetable {
    
    
    func showAlert(with alertMessage: AlertMessage, completion: @escaping () -> Void) {
        showAlert(
            title: alertMessage.title,
            message: alertMessage.message,
            actions: [UIAlertAction(title: alertMessage.actionTitle, style: .default) { _ in
                completion()
            }]
        )
    }
    
    func showAlert(with alertMessage: AlertMessage) {
        showAlert(
            title: alertMessage.title,
            message: alertMessage.message,
            actions: [UIAlertAction(title: alertMessage.actionTitle, style: .default)]
        )
    }
    
    
}

extension AddAdViewController: Alertable, ActionSheetable {
    func showAlert(with alertMessage: AlertMessage, completion: @escaping () -> Void) {
        showAlert(
            title: alertMessage.title,
            message: alertMessage.message,
            actions: [UIAlertAction(title: alertMessage.actionTitle, style: .default) { _ in
                completion()
            }]
        )
    }
    
    func showAlert(with alertMessage: AlertMessage) {
        showAlert(
            title: alertMessage.title,
            message: alertMessage.message,
            actions: [UIAlertAction(title: alertMessage.actionTitle, style: .default)]
        )
    }
}

extension AddAdViewController: UITextFieldDelegate {
    
}

