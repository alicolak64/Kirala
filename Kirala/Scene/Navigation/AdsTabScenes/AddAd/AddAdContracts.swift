//
//  AddAdContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import UIKit
import Photos

protocol AddAdBuilderProtocol {
    static func build(rootNavigationController: UINavigationController?,navigationController: UINavigationController?) -> UIViewController
    static func build(rootNavigationController: UINavigationController?,navigationController: UINavigationController?, arguments: EditAddAdArguments) -> UIViewController
}

enum AddAdRoute {
    case back
    case location(AddAdViewModel)
}

protocol  AddAdRouterProtocol {
    func navigate(to route:  AddAdRoute)
}

enum AddAdTableViewTag: Int {
    case image = 0
    case closedRange = 1
}

protocol AddAdViewModelProtocol {
    
    // MARK: Dependency Properties
    var delegate: AddAdViewProtocol? { get set }
    
    // MARK: Lifecycle Methods
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidLayoutSubviews()
    func viewDidAppear()
    func viewDidDisappear()
        
    // MARK: Actions
    func didTapCancelButton()
    func didTapAddImageButton()
    func didTapSelectLocationButton()
    func didTapAddClosedRangeButton()
    func didTapDeleteButton(with index: Int, type: AddAdTableViewTag)
    func didSelectCalendarValue(with value: FastisValue?)
    func didTapDateLabel(with indexPath: IndexPath)
    
    // MARK: Methods
    func didSelectRow(at index: Int, type: PickerViewType)
    func textFieldDidChanged(text: String, type: TextFieldWithTitleType)
    
    // MARK: Data Source Methods
    func numberOfSections(type: AddAdTableViewTag) -> Int
    func headerInSection(in section: Int, type: AddAdTableViewTag) -> Any?
    func heightForHeaderInSection(in section: Int, type: AddAdTableViewTag) -> CGFloat
    func numberOfRows(in section: Int, type: AddAdTableViewTag) -> Int
    func cellForRow(at indexPath: IndexPath, type: AddAdTableViewTag) -> Any?
    func heightForRow(at indexPath: IndexPath, type: AddAdTableViewTag) -> CGFloat
    func didSelectRow(at indexPath: IndexPath, type: AddAdTableViewTag)
    
    func isImageSelected(identifier: String) -> Bool
    func sortSelectedItems(assets: [PHAsset], completion: @escaping ([PHAsset]) -> Void)
    func didSelectImages(assets: [PHAsset])
    
}


protocol AddAdViewProtocol: AnyObject {
    
    // MARK: Methods
    
    func prepareNavigationBar(title: String)
    func prepareUI()
    func prepareConstraints()
    func addTapGesture()
    
    func prepareCategoryPickerView(with categories: [String])
    func prepareSubcategoryPickerView(with subcategories: [String])
    func prepareBrandPickerView(with brands: [String])
    func prepareCityPickerView(with cities: [String])
    func prepareNameTextField()
    func preparePriceTextField()
    func prepareDescriptionTextField()
    func prepareMinMaxPeriodTextField()
    func prepareImagesTableView()
    func prepareClosedRangeTableView()
    
    func prepareAddAdFooter()
    func prepareEditAdFooter()
    
    func prepareCalendar(
        minDate: Date,
        maxDate: Date,
        selectMonthOnHeaderTap: Bool,
        allowToChooseNilDate: Bool,
        shortcuts: [FastisShortcut<FastisRange>],
        closedRanges: [FastisRange]
    )
    
    func showCalendar(with value: FastisValue?)
    func updateClosedRanges(with ranges: [FastisRange])
    
    func layoutIfNeeded()
    func setPickerViewHeightConstraint(to constant: CGFloat, type: PickerViewType)
    func showCustomTextFieldPickerView(type: PickerViewType, animated: Bool, firstResponder: Bool)
    func hideCustomTextFieldPickerView(type: PickerViewType, animated: Bool)
    
    func setTableViewHeightConstraint(type: AddAdTableViewTag, to constant: CGFloat)
    
    func showImagePicker()
    func reloadTableView(with type: AddAdTableViewTag)
    func reloadItems(at indexPaths: [IndexPath], type: AddAdTableViewTag)
    func deleteItems(at indexPaths: [IndexPath], type: AddAdTableViewTag)
    
    func showMapView(with cgLocation: CLLocationCoordinate2D, annotationTitle: String)
        
}
