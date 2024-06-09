//
//  TextFieldWithTitle.swift
//  SwiftTips
//
//  Created by Ali Çolak on 8.06.2024.
//

import UIKit

final class TextFieldWithTitle: UIView {
    
    var presenter: TextFieldWithTitlePresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = ColorText.primary.dynamicColor
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.setCustomBorder()
        return textField
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isHidden = true
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.setCustomBorder()
        return textView
    }()
    
    private lazy var textFieldTipLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = ColorText.secondary.dynamicColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var textViewTipLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = ColorText.secondary.dynamicColor
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubviews([
            titleLabel,
            textField,
            textFieldTipLabel
        ])
                
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            textFieldTipLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            textFieldTipLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldTipLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textFieldTipLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
    }
    
}

extension TextFieldWithTitle: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        presenter.textFieldDidChanged(textView.text)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == presenter.getPleaceholder() {
            textView.text = nil
            textView.textColor = ColorText.primary.dynamicColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = presenter.getPleaceholder()
            textView.textColor = UIColor.lightGray
        }
    }
    
}

extension TextFieldWithTitle: TextFieldWithTitleViewProtocol {
    
    
    func prepareTextField() {
        textField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        textView.delegate = self
    }
    
    func setTextFieldTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setTextFieldPlaceholder(_ placeholder: String) {
        textField.placeholder = placeholder
    }
    
    func setTextFieldText(_ text: String) {
        textField.text = text
    }
    
    func setTextViewText(_ text: String) {
        textView.text = text
    }
    
    func setTextViewPlaceholder(_ placeholder: String) {
        textView.text = placeholder
        textView.textColor = .lightGray
    }
    
    @objc private func textFieldDidChanged() {
        presenter.textFieldDidChanged(textField.text ?? "")
    }
    
    func setTextFieldTip(_ tip: String) {
        textFieldTipLabel.text = tip
    }
    
    func setTextViewTip(_ tip: String) {
        textViewTipLabel.text = tip
    }
    
    func setTextFieldType(_ type: TextFieldWithTitleType) {
        switch type {
        case .name:
            textField.keyboardType = .default
        case .price:
            textField.keyboardType = .decimalPad
        case .description:
            addSubviews([
                textView,
                textViewTipLabel
            ])
            textField.removeFromSuperview()
            textFieldTipLabel.removeFromSuperview()
            NSLayoutConstraint.activate([
                textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                textView.leadingAnchor.constraint(equalTo: leadingAnchor),
                textView.trailingAnchor.constraint(equalTo: trailingAnchor),
                textView.heightAnchor.constraint(equalToConstant: 100),
                
                textViewTipLabel.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 4),
                textViewTipLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                textViewTipLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                textViewTipLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            textField.isHidden = true
            textFieldTipLabel.isHidden = true
            textView.isHidden = false
            textViewTipLabel.isHidden = false
        }
    }
    
}



