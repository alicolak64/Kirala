//
//  PickerView.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import UIKit

final class PickerView: UIView {
    
    var presenter: PickerViewPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    // MARK: - UI Properties
    
    private lazy var pickerViewTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = ColorText.primary.dynamicColor
        return label
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private lazy var pickerViewTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.tintColor = .clear
        textField.setCustomBorder()
        return textField
    }()
    
    private lazy var pickerViewTipLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = ColorText.secondary.dynamicColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView(image: Symbols.chevronRight.symbol())
        imageView.tintColor = ColorPalette.appPrimary.dynamicColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    private lazy var customTextFieldTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = ColorText.primary.dynamicColor
        label.isHidden = true
        return label
    }()
    
    private let customTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.isHidden = true
        textField.setCustomBorder()
        return textField
    }()
    
    private lazy var customTextFieldTipLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = ColorText.secondary.dynamicColor
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
        
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        backgroundColor = ColorBackground.primary.dynamicColor
        addSubviews([
            pickerViewTitleLabel,
            pickerViewTextField,
            chevronImageView,
            pickerViewTipLabel,
        ])
                
        NSLayoutConstraint.activate([
            
            pickerViewTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            pickerViewTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerViewTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            pickerViewTextField.topAnchor.constraint(equalTo: pickerViewTitleLabel.bottomAnchor, constant: 8),
            pickerViewTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            pickerViewTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            pickerViewTextField.heightAnchor.constraint(equalToConstant: 40),
            
            chevronImageView.centerYAnchor.constraint(equalTo: pickerViewTextField.centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: pickerViewTextField.trailingAnchor, constant: -8),
            chevronImageView.widthAnchor.constraint(equalToConstant: 15),
            
            pickerViewTipLabel.topAnchor.constraint(equalTo: pickerViewTextField.bottomAnchor, constant: 4),
            pickerViewTipLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            pickerViewTipLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
        
    }
    
    private func createPickerViewToolbar() -> UIToolbar {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(
            title: Strings.Common.done.localized,
            style: .done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [space, doneButton]
        
        return toolbar
    }
    
    @objc private func doneButtonTapped() {
        closePickerView()
        closeCustomTextField()
    }
    
    @objc private func customTextFieldTextDidChanged() {
        presenter.customTextFieldTextDidChanged(customTextField.text ?? "")
    }
    
}

// MARK: - PickerViewViewProtocol

extension PickerView: PickerViewViewProtocol {
    
    func setPickerViewTipLabel(_ text: String) {
        pickerViewTipLabel.text = text
    }
    
    func setCustomTextFieldTipLabel(_ text: String) {
        customTextFieldTipLabel.text = text
    }
    
    
    func setPickerViewTitle(_ title: String) {
        pickerViewTitleLabel.text = title
    }
    
    func setCustomTextFieldTitle(_ title: String) {
        customTextFieldTitleLabel.text = title
    }
    
    func preparePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func preparePickerViewTextField() {
        pickerViewTextField.inputView = pickerView
        pickerViewTextField.inputAccessoryView = createPickerViewToolbar()
        pickerViewTextField.delegate = self
    }
    
    func prepareCustomTextField() {
        customTextField.delegate = self
        customTextField.addTarget(self, action: #selector(customTextFieldTextDidChanged), for: .editingChanged)
    }
    
    func setPickerViewPlaceholder(_ placeholder: String) {
        pickerViewTextField.placeholder = placeholder
    }
    
    func setCustomTextFieldPlaceholder(_ placeholder: String) {
        customTextField.placeholder = placeholder
    }
    
    func reloadPickerView() {
        pickerView.reloadAllComponents()
    }
    
    func showCustomTextField(animated: Bool, firstResponder: Bool) {
        
        addSubviews([
            customTextFieldTitleLabel,
            customTextField,
            customTextFieldTipLabel,
        ])
        
        NSLayoutConstraint.activate([
            
            customTextFieldTitleLabel.topAnchor.constraint(equalTo: pickerViewTipLabel.bottomAnchor, constant: 10),
            customTextFieldTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            customTextFieldTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            customTextField.topAnchor.constraint(equalTo: customTextFieldTitleLabel.bottomAnchor, constant: 8),
            customTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            customTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            customTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            customTextField.heightAnchor.constraint(equalToConstant: 40),
            
            customTextFieldTipLabel.topAnchor.constraint(equalTo: customTextField.bottomAnchor, constant: 4),
            customTextFieldTipLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            customTextFieldTipLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
        
        if animated {
            customTextField.alpha = 0
            customTextField.isHidden = false
            customTextFieldTitleLabel.alpha = 0
            customTextFieldTitleLabel.isHidden = false
            customTextFieldTipLabel.alpha = 0
            customTextFieldTipLabel.isHidden = false
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.customTextField.alpha = 1
                self?.customTextFieldTitleLabel.alpha = 1
                self?.customTextFieldTipLabel.alpha = 1
            }) { [weak self] _ in
                if firstResponder {
                    self?.customTextField.becomeFirstResponder()
                }
            }
        } else {
            customTextFieldTitleLabel.isHidden = false
            customTextField.isHidden = false
            customTextFieldTipLabel.isHidden = false
            if firstResponder {
                customTextField.becomeFirstResponder()
            }
        }
        
    }

    func hideCustomTextField(animated: Bool) {
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.customTextField.alpha = 0
                self?.customTextFieldTitleLabel.alpha = 0
                self?.customTextFieldTipLabel.alpha = 0
            }) { [weak self] _ in
                self?.customTextField.isHidden = true
                self?.customTextField.alpha = 1
                self?.customTextFieldTitleLabel.isHidden = true
                self?.customTextFieldTitleLabel.alpha = 1
                self?.customTextFieldTipLabel.isHidden = true
                self?.customTextFieldTipLabel.alpha = 1
            }
        } else {
            customTextField.isHidden = true
            customTextFieldTitleLabel.isHidden = true
            customTextFieldTipLabel.isHidden = true
        }
        
        customTextField.removeFromSuperview()
        customTextFieldTitleLabel.removeFromSuperview()
        customTextFieldTipLabel.removeFromSuperview()
        
    }
    
    func setCustomTextFieldText(_ text: String) {
        customTextField.text = text
    }
    
    func setPickerViewSelectedRow(at index: Int) {
        pickerView.selectRow(index, inComponent: 0, animated: false)
    }
    
    func setPickerViewTextFieldText(_ text: String) {
        pickerViewTextField.text = text
    }
    
    func closePickerView() {
        pickerViewTextField.resignFirstResponder()
    }
    
    func closeCustomTextField() {
        customTextField.resignFirstResponder()
    }
    
    func updateItems(_ items: [String]) {
        presenter.updateItems(items)
    }
    
    
}

// MARK: - UIPickerViewDataSource - UIPickerViewDelegate

extension PickerView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        presenter.numberOfComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter.numberOfRows()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presenter.titleForRow(at: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter.didSelectRow(at: row)
    }
    
}

// MARK: - UITextFieldDelegate

extension PickerView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter.textFieldShouldReturn(isPickerViewTextField: textField == pickerViewTextField)
        
    }
        
}

