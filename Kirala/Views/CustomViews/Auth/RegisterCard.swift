//
//  RegisterCard.swift
//  Kirala
//
//  Created by Ali Çolak on 25.05.2024.
//

import UIKit

protocol RegisterCardDelegate: AnyObject {
    func didTapLoginButton()
    func didTapRegisterButton(email: String, password: String)
    func didTapLoginWithAppleButton()
    func didTapLoginWithGoogleButton()
}

protocol RegisterCardProtocol {
    var delegate: RegisterCardDelegate? { get set }
    func showWarningMessageEmail()
    func hideWarningMessageEmail()
    func showWarningMessagePassword()
    func hideWarningMessagePassword()
}

final class RegisterCard: UIView, RegisterCardProtocol {
    
    weak var delegate: RegisterCardDelegate?
    
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
    
    private lazy var passwordTipLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.auth.localizedString(for: "PASSWORD_TIP")
        label.textColor = ColorPalette.gray.dynamicColor
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var acceptTermsLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.auth.localizedString(for: "ACCEPT_MEMBERSHIP_TERMS")
        label.textColor = ColorPalette.gray.dynamicColor
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var term1View: UIView = {
        let view = UIView()
        let radioButton = RadioButton()
        radioButton.configure(with: .checkmark)
        radioButton.setUncheckedImage()
        let termLabel = UILabel()
        termLabel.text = Localization.auth.localizedString(for: "CONSENT_FOR_OFFERS")
        termLabel.textColor = ColorPalette.gray.dynamicColor
        termLabel.numberOfLines = 0
        termLabel.lineBreakMode = .byWordWrapping
        termLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        termLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews([radioButton, termLabel])
        
        NSLayoutConstraint.activate([
            radioButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            radioButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            radioButton.widthAnchor.constraint(equalToConstant: 15),
            
            termLabel.topAnchor.constraint(equalTo: view.topAnchor),
            termLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 10),
            termLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            termLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var term2View: UIView = {

        let view = UIView()
        let radioButton = RadioButton()
        radioButton.configure(with: .checkmark)
        radioButton.setUncheckedImage()
        let termLabel = UILabel()
        termLabel.text = Localization.auth.localizedString(for: "AGREE_TO_RECEIVE_MESSAGES")
        termLabel.textColor = ColorPalette.gray.dynamicColor
        termLabel.numberOfLines = 0
        termLabel.lineBreakMode = .byWordWrapping
        termLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        termLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews([radioButton, termLabel])
        
        NSLayoutConstraint.activate([
            radioButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            radioButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            radioButton.widthAnchor.constraint(equalToConstant: 15),
            
            termLabel.topAnchor.constraint(equalTo: view.topAnchor),
            termLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 10),
            termLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            termLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var term3View: UIView = {
        let view = UIView()
        let radioButton = RadioButton()
        radioButton.configure(with: .checkmark)
        radioButton.setUncheckedImage()
        let termLabel = UILabel()
        termLabel.text = Localization.auth.localizedString(for: "ACKNOWLEDGE_PRIVACY_POLICY")
        termLabel.textColor = ColorPalette.gray.dynamicColor
        termLabel.numberOfLines = 0
        termLabel.lineBreakMode = .byWordWrapping
        termLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        termLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews([radioButton, termLabel])
        
        NSLayoutConstraint.activate([
            radioButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            radioButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            radioButton.widthAnchor.constraint(equalToConstant: 15),
            
            termLabel.topAnchor.constraint(equalTo: view.topAnchor),
            termLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 10),
            termLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            termLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.auth.localizedString(for: "REGISTER"), for: .normal)
        button.backgroundColor = ColorPalette.appPrimary.dynamicColor
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.addCornerRadius(radius: 5)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var otherLoginOptionsLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.auth.localizedString(for: "OTHER_REGISTER_OPTIONS")
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
        
        button.setTitle(Localization.auth.localizedString(for: "REGISTER_WITH_APPLE"), for: .normal)
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
        
        button.setTitle(Localization.auth.localizedString(for: "REGISTER_WITH_GOOGLE"), for: .normal)
        button.setImage(Images.google.image.resizeImage(to: CGSize(width: 20, height: 20)), for: .normal)
        button.tintColor = ColorText.quaternary.dynamicColor
        button.backgroundColor = ColorPalette.white.dynamicColor
        button.addCornerRadius(radius: 5)
        button.addBorder(width: 1, color: ColorPalette.border.dynamicColor)
        button.addTarget(self, action: #selector(didTapLoginWithGoogleButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var loginContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.auth.localizedString(for: "ALREADY_HAVE_ACCOUNT")
        label.textColor = ColorPalette.gray.dynamicColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.auth.localizedString(for: "LOGIN"), for: .normal)
        button.setTitleColor(ColorPalette.appPrimary.dynamicColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
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
        loginContainer.addSubviews([
            loginLabel,
            loginButton
        ])
        addSubviews([
            emailContainer,
            passwordContainer,
            passwordTipLabel,
            acceptTermsLabel,
            term1View,
            term2View,
            term3View,
            registerButton,
            otherLoginOptionsLabel,
            loginWithAppleButton,
            loginWithGoogleButton,
            loginContainer,
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
            
            passwordTipLabel.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 8),
            passwordTipLabel.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor),
            passwordTipLabel.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor),
            
            acceptTermsLabel.topAnchor.constraint(equalTo: passwordTipLabel.bottomAnchor, constant: 8),
            acceptTermsLabel.leadingAnchor.constraint(equalTo: passwordTipLabel.leadingAnchor),
            acceptTermsLabel.trailingAnchor.constraint(equalTo: passwordTipLabel.trailingAnchor),
            
            term1View.topAnchor.constraint(equalTo: acceptTermsLabel.bottomAnchor, constant: 8),
            term1View.leadingAnchor.constraint(equalTo: acceptTermsLabel.leadingAnchor),
            term1View.trailingAnchor.constraint(equalTo: acceptTermsLabel.trailingAnchor),
            term1View.heightAnchor.constraint(equalToConstant: 30),
            
            term2View.topAnchor.constraint(equalTo: term1View.bottomAnchor, constant: 8),
            term2View.leadingAnchor.constraint(equalTo: term1View.leadingAnchor),
            term2View.trailingAnchor.constraint(equalTo: term1View.trailingAnchor),
            term2View.heightAnchor.constraint(equalTo: term1View.heightAnchor),
            
            term3View.topAnchor.constraint(equalTo: term2View.bottomAnchor, constant: 8),
            term3View.leadingAnchor.constraint(equalTo: term2View.leadingAnchor),
            term3View.trailingAnchor.constraint(equalTo: term2View.trailingAnchor),
            term3View.heightAnchor.constraint(equalTo: term2View.heightAnchor),
            
            registerButton.topAnchor.constraint(equalTo: term3View.bottomAnchor, constant: 16),
            registerButton.leadingAnchor.constraint(equalTo: acceptTermsLabel.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: acceptTermsLabel.trailingAnchor),
            registerButton.heightAnchor.constraint(equalTo: emailContainer.heightAnchor),
            
            otherLoginOptionsLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 16),
            otherLoginOptionsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            loginWithAppleButton.topAnchor.constraint(equalTo: otherLoginOptionsLabel.bottomAnchor, constant: 16),
            loginWithAppleButton.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor),
            loginWithAppleButton.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor),
            loginWithAppleButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            
            loginWithGoogleButton.topAnchor.constraint(equalTo: loginWithAppleButton.bottomAnchor, constant: 8),
            loginWithGoogleButton.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor),
            loginWithGoogleButton.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor),
            loginWithGoogleButton.heightAnchor.constraint(equalTo: loginButton.heightAnchor),
            
            loginContainer.topAnchor.constraint(equalTo: loginWithGoogleButton.bottomAnchor, constant: 16),
            loginContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            loginLabel.topAnchor.constraint(equalTo: loginContainer.topAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: loginContainer.leadingAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: loginContainer.bottomAnchor),
            
            loginButton.topAnchor.constraint(equalTo: loginContainer.topAnchor),
            loginButton.leadingAnchor.constraint(equalTo: loginLabel.trailingAnchor, constant: 4),
            loginButton.bottomAnchor.constraint(equalTo: loginContainer.bottomAnchor),
            loginButton.trailingAnchor.constraint(equalTo: loginContainer.trailingAnchor),
            
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapLoginButton() {
        delegate?.didTapLoginButton()
    }
    
    @objc private func didTapRegisterButton() {
        delegate?.didTapRegisterButton(email: emailContainer.getEmail() ?? "", password: passwordContainer.getPassword() ?? "")
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
