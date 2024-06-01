//
//  PasswordContainer.swift
//  Kirala
//
//  Created by Ali Çolak on 24.05.2024.
//

import UIKit

enum PasswordState {
    case visible
    case hidden
    
    mutating func toggle() {
        switch self {
        case .visible:
            self = .hidden
        case .hidden:
            self = .visible
        }
    }
    
}

protocol PasswordContainerProtocol {
    func showWarning()
    func hideWarning()
    func getPassword() -> String?
}

final class PasswordContainer: UIView, PasswordContainerProtocol {
    
    // MARK: - Properties
        
    private var state: ContainerState = .normal {
        didSet {
            updateContainerState()
        }
    }
    
    private var passwordState: PasswordState = .hidden {
        didSet {
            updatePasswordState()
        }
    }
    
    private lazy var passwordTextField: AutoCompleteTextField = {
        let view = AutoCompleteTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.attributedPlaceholder = NSAttributedString(string: Localization.auth.localizedString(for: "PASSWORD_PLACEHOLDER"), attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ])
        view.autoCompleteType = .email
        view.isSecureTextEntry = true
        return view
    }()
    
    private lazy var visibilityButton: UIButton = {
        let button = UIButton()
        button.setImage(Symbols.eyeSlash.symbol(), for: .normal)
        button.tintColor = ColorPalette.gray.dynamicColor
        button.addTarget(self, action: #selector(visibilityButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    /// Sets up the layout of the loading view.
    private func setupLayout() {
        addBorder(width: 1, color: ColorPalette.border.dynamicColor)
        addCornerRadius(radius: 5)        
        backgroundColor = ColorBackground.secondary.dynamicColor
        addSubviews([
            passwordTextField,
            visibilityButton
        ])
        setupConstraints()
    }
    
    /// Sets up the constraints for the loading view.
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -31),
            passwordTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            
            visibilityButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            visibilityButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            visibilityButton.widthAnchor.constraint(equalToConstant: 20),
            visibilityButton.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    
    // MARK: - Actions
    
    @objc private func visibilityButtonTapped() {
        passwordState.toggle()
    }
    
    // MARK: - Methods
    
    /// Updates the loading state of the view.
    private func updateContainerState() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch self.state {
            case .normal:
                addRoundedBorder(width: 1, color: ColorPalette.border.dynamicColor)
                backgroundColor = ColorBackground.secondary.dynamicColor
                
            case .warning:
                addRoundedBorder(width: 1, color: ColorText.warning.dynamicColor)
                backgroundColor = ColorBackground.warning.dynamicColor
            }
        }
    }
    
    func showWarning() {
        state = .warning
    }
    
    func hideWarning() {
        state = .normal
    }
    
    func getPassword() -> String? {
        passwordTextField.text
    }
    
    private func updatePasswordState() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch self.passwordState {
            case .visible:
                visibilityButton.setImage(Symbols.eye.symbol(), for: .normal)
                passwordTextField.isSecureTextEntry = false
            case .hidden:
                visibilityButton.setImage(Symbols.eyeSlash.symbol(), for: .normal)
                passwordTextField.isSecureTextEntry = true
            }
        }
    }
    
}

