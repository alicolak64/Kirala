//
//  LoginCard.swift
//  Kirala
//
//  Created by Ali Çolak on 25.05.2024.
//

import UIKit

protocol LoginCardDelegate: AnyObject {
    func didTapLoginButton(email: String, password: String)
    func didTapRegisterButton()
    func didTapForgotPasswordButton()
    func didTapLoginWithAppleButton()
    func didTapLoginWithGoogleButton()
}

protocol LoginCardProtocol {
    var delegate: LoginCardDelegate? { get set }
    func showWarningMessageEmail()
    func hideWarningMessageEmail()
    func showWarningMessagePassword()
    func hideWarningMessagePassword()
}

final class LoginCard: UIView, LoginCardProtocol {
    
    weak var delegate: LoginCardDelegate?
    
    // MARK: - UI Components
    
    private lazy var emailContainer: EmailContainer = {
        let view = EmailContainer()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var passwordContainer: PasswordContainer = {
        let view = PasswordContainer()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.auth.localizedString(for: "FORGOT_PASSWORD"), for: .normal)
        button.setTitleColor(ColorPalette.appSecondary.dynamicColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.auth.localizedString(for: "LOGIN"), for: .normal)
        button.backgroundColor = ColorPalette.appPrimary.dynamicColor
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.addCornerRadius(radius: 5)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var otherLoginOptionsLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.auth.localizedString(for: "OTHER_LOGIN_OPTIONS")
        label.textColor = ColorPalette.gray.dynamicColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginWithAppleButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .leading
        config.imagePadding = 10
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var attributes = attributes
            attributes.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            return attributes
        }
        
        button.configuration = config
        
        button.setTitle(Localization.auth.localizedString(for: "LOGIN_WITH_APPLE"), for: .normal)
        button.setImage(Symbols.appleLogo.symbol(), for: .normal)
        button.tintColor = ColorPalette.white.dynamicColor
        button.backgroundColor = ColorPalette.black.dynamicColor
        button.addCornerRadius(radius: 5)
        button.addTarget(self, action: #selector(didTapLoginWithAppleButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var loginWithGoogleButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .leading
        config.imagePadding = 10
        
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var attributes = attributes
            attributes.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            return attributes
        }
        
        button.configuration = config
        
        button.setTitle(Localization.auth.localizedString(for: "LOGIN_WITH_GOOGLE"), for: .normal)
        button.setImage(Images.google.image.resizeImage(to: CGSize(width: 20, height: 20)), for: .normal)
        button.tintColor = ColorText.quaternary.dynamicColor
        button.backgroundColor = ColorPalette.white.dynamicColor
        button.addCornerRadius(radius: 5)
        button.addBorder(width: 1, color: ColorPalette.border.dynamicColor)
        button.addTarget(self, action: #selector(didTapLoginWithGoogleButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var registerContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.auth.localizedString(for: "NO_ACCOUNT")
        label.textColor = ColorPalette.gray.dynamicColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.auth.localizedString(for: "REGISTER"), for: .normal)
        button.setTitleColor(ColorPalette.appPrimary.dynamicColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
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
        makeCardStyle()
        registerContainer.addSubviews([
            registerLabel,
            registerButton
        ])
        addSubviews([
            emailContainer,
            passwordContainer,
            forgotPasswordButton,
            loginButton,
            otherLoginOptionsLabel,
            loginWithAppleButton,
            loginWithGoogleButton,
            registerContainer
        ])
        setupConstraints()
    }
    
    /// Sets up the constraints for the loading view.
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emailContainer.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            emailContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            emailContainer.heightAnchor.constraint(equalToConstant: 40),
            
            passwordContainer.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: 16),
            passwordContainer.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor),
            passwordContainer.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor),
            passwordContainer.heightAnchor.constraint(equalTo: emailContainer.heightAnchor),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 8),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor),
            loginButton.heightAnchor.constraint(equalTo: emailContainer.heightAnchor),
            
            
            otherLoginOptionsLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            otherLoginOptionsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            loginWithAppleButton.topAnchor.constraint(equalTo: otherLoginOptionsLabel.bottomAnchor, constant: 16),
            loginWithAppleButton.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor),
            loginWithAppleButton.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor),
            loginWithAppleButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            
            loginWithGoogleButton.topAnchor.constraint(equalTo: loginWithAppleButton.bottomAnchor, constant: 8),
            loginWithGoogleButton.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor),
            loginWithGoogleButton.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor),
            loginWithGoogleButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            
            registerContainer.topAnchor.constraint(equalTo: loginWithGoogleButton.bottomAnchor, constant: 16),
            registerContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            registerLabel.topAnchor.constraint(equalTo: registerContainer.topAnchor),
            registerLabel.leadingAnchor.constraint(equalTo: registerContainer.leadingAnchor),
            registerLabel.bottomAnchor.constraint(equalTo: registerContainer.bottomAnchor),
            
            registerButton.topAnchor.constraint(equalTo: registerContainer.topAnchor),
            registerButton.leadingAnchor.constraint(equalTo: registerLabel.trailingAnchor, constant: 4),
            registerButton.bottomAnchor.constraint(equalTo: registerContainer.bottomAnchor),
            registerButton.trailingAnchor.constraint(equalTo: registerContainer.trailingAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapLoginButton() {
        delegate?.didTapLoginButton(email: emailContainer.getEmail() ?? "", password: passwordContainer.getPassword() ?? "")
    }
    
    @objc private func didTapRegisterButton() {
        delegate?.didTapRegisterButton()
    }
    
    @objc private func didTapForgotPasswordButton() {
        delegate?.didTapForgotPasswordButton()
    }
    
    @objc private func didTapLoginWithAppleButton() {
        delegate?.didTapLoginWithAppleButton()
    }
    
    @objc private func didTapLoginWithGoogleButton() {
        delegate?.didTapLoginWithGoogleButton()
    }
    
    func showWarningMessageEmail() {
        emailContainer.showWarning()
    }
    
    func hideWarningMessageEmail() {
        emailContainer.hideWarning()
    }
    
    func showWarningMessagePassword() {
        passwordContainer.showWarning()
    }
    
    func hideWarningMessagePassword() {
        passwordContainer.hideWarning()
    }
    
}
