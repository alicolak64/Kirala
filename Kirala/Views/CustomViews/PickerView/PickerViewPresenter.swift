//
//  PickerViewPresenter.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import Foundation

enum PickerViewType {
    case category
    case subcategory
    case city
    case brand
}

struct CustomTextFieldArguments {
    let placeholder: String
    let text: String?
}

struct PickerViewArguments {
    let pickerViewTitle: String
    let pickerViewPlaceholder: String
    let pickerViewTip: String
    let customTextFieldTitle: String
    let customTextFieldPlaceholder: String
    let customTextFieldTip: String
    let items: [String]
    let selectedItem: String?
    let customTextFieldArguments: CustomTextFieldArguments?
    let pickerViewType: PickerViewType
}

protocol PickerViewDelegate: AnyObject {
    func didSelectRow(at index: Int, pickerViewType: PickerViewType)
}

protocol PickerViewPresenterProtocol {
    var delegate: PickerViewDelegate? { get set }
    func load()
    func numberOfComponents() -> Int
    func numberOfRows() -> Int
    func titleForRow(at index: Int) -> String?
    func didSelectRow(at index: Int)
    func textFieldShouldReturn(isPickerViewTextField: Bool) -> Bool
}

protocol PickerViewViewProtocol: AnyObject {
    func preparePickerView()
    func preparePickerViewTextField()
    func prepareCustomTextField()
    func setPickerViewTitle(_ title: String)
    func setPickerViewPlaceholder(_ placeholder: String)
    func setPickerViewTipLabel(_ text: String)
    func setCustomTextFieldTitle(_ title: String)
    func setCustomTextFieldPlaceholder(_ placeholder: String)
    func setCustomTextFieldTipLabel(_ text: String)
    func setPickerViewTextFieldText(_ text: String)
    func reloadPickerView()
    func showCustomTextField(animated: Bool, firstResponder: Bool)
    func hideCustomTextField(animated: Bool)
    func setCustomTextFieldText(_ text: String)
    func setPickerViewSelectedRow(at index: Int)
    func closePickerView()
    func closeCustomTextField()
}

final class PickerViewPresenter {
    
    // MARK: - Properties
    
    weak var delegate: PickerViewDelegate?
    private weak var view: PickerViewViewProtocol?
    
    private let arguments: PickerViewArguments
    
    // MARK: - Init
    
    init(view: PickerViewViewProtocol, arguments: PickerViewArguments) {
        self.view = view
        self.arguments = arguments
    }
    
}

// MARK: - PickerViewPresenterProtocol

extension PickerViewPresenter: PickerViewPresenterProtocol {
    
    func load() {
        view?.setPickerViewTitle(arguments.pickerViewTitle)
        view?.setPickerViewPlaceholder(arguments.pickerViewPlaceholder)
        view?.setPickerViewTipLabel(arguments.pickerViewTip)
        view?.setCustomTextFieldTitle(arguments.customTextFieldTitle)
        view?.setCustomTextFieldPlaceholder(arguments.customTextFieldPlaceholder)
        view?.setCustomTextFieldTipLabel(arguments.customTextFieldTip)
        view?.preparePickerView()
        view?.preparePickerViewTextField()
        view?.prepareCustomTextField()
        view?.reloadPickerView()
        
        if let customTextFieldArguments = arguments.customTextFieldArguments {
            view?.showCustomTextField(animated: false, firstResponder: false)
            view?.setCustomTextFieldText(customTextFieldArguments.text ?? "")
        } else {
            view?.hideCustomTextField(animated: false)
        }
        
        if let selectedItem = arguments.selectedItem, let index = arguments.items.firstIndex(of: selectedItem) {
            view?.setPickerViewSelectedRow(at: index)
        }
    }
    
    func numberOfComponents() -> Int {
        1
    }
    
    func numberOfRows() -> Int {
        arguments.items.count
    }
    
    func titleForRow(at index: Int) -> String? {
        guard arguments.items.indices.contains(index) else { return nil }
        return arguments.items[index]
    }
    
    func didSelectRow(at index: Int) {
        guard arguments.items.indices.contains(index) else { return }
        delegate?.didSelectRow(at: index, pickerViewType: arguments.pickerViewType)
        view?.setPickerViewTextFieldText(arguments.items[index])
    }
    
    func textFieldShouldReturn(isPickerViewTextField: Bool) -> Bool {
        if isPickerViewTextField {
            view?.closePickerView()
        } else {
            view?.closeCustomTextField()
        }
        return true
    }
    
}
