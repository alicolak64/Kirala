//
//  ResetPasswordCard.swift
//  Kirala
//
//  Created by Ali Çolak on 5.06.2024.
//

import UIKit

protocol ResetPasswordCardDelegate: AnyObject {
    func didTapResetPasswordButton(password: String, confirmPassword: String)
}

protocol ResetPasswordCardProtocol {
    var delegate: ResetPasswordCardDelegate? { get set }
    func showWarningMessagePassword()
    func hideWarningMessagePassword()
}

final class ResetPasswordCard: UIView, ResetPasswordCardProtocol {
    
    
    weak var delegate: ResetPasswordCardDelegate?
    
    // MARK: - UI Components
    
    private lazy var resetPasswordTipLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Auth.resetPasswordTip.localized
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.textColor = ColorText.primary.dynamicColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var passwordContainer: PasswordContainer = {
        let view = PasswordContainer()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var confirmPasswordContainer: PasswordContainer = {
        let view = PasswordContainer()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var passwordTipLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Auth.passwordTip.localized
        label.textColor = ColorPalette.gray.dynamicColor
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var resetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.Auth.resetPassword.localized, for: .normal)
        button.backgroundColor = ColorPalette.appPrimary.dynamicColor
        button.addTarget(self, action: #selector(didTapResetPasswordButton), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.addCornerRadius(radius: 5)
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
        
        addSubviews([
            resetPasswordTipLabel,
            passwordContainer,
            confirmPasswordContainer,
            passwordTipLabel,
            resetPasswordButton
        ])
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            resetPasswordTipLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            resetPasswordTipLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            resetPasswordTipLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            passwordContainer.topAnchor.constraint(equalTo: resetPasswordTipLabel.bottomAnchor, constant: 16),
            passwordContainer.leadingAnchor.constraint(equalTo: resetPasswordTipLabel.leadingAnchor),
            passwordContainer.trailingAnchor.constraint(equalTo: resetPasswordTipLabel.trailingAnchor),
            passwordContainer.heightAnchor.constraint(equalToConstant: 40),
            
            confirmPasswordContainer.topAnchor.constraint(equalTo: passwordContainer.bottomAnchor, constant: 16),
            confirmPasswordContainer.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor),
            confirmPasswordContainer.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor),
            confirmPasswordContainer.heightAnchor.constraint(equalTo: passwordContainer.heightAnchor),
            
            passwordTipLabel.topAnchor.constraint(equalTo: confirmPasswordContainer.bottomAnchor, constant: 8),
            passwordTipLabel.leadingAnchor.constraint(equalTo: confirmPasswordContainer.leadingAnchor),
            passwordTipLabel.trailingAnchor.constraint(equalTo: confirmPasswordContainer.trailingAnchor),

            resetPasswordButton.topAnchor.constraint(equalTo: passwordTipLabel.bottomAnchor, constant: 16),
            resetPasswordButton.leadingAnchor.constraint(equalTo: passwordTipLabel.leadingAnchor),
            resetPasswordButton.trailingAnchor.constraint(equalTo: passwordTipLabel.trailingAnchor),
            resetPasswordButton.heightAnchor.constraint(equalTo: passwordContainer.heightAnchor),
            
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapResetPasswordButton() {
        delegate?.didTapResetPasswordButton(password: passwordContainer.getPassword() ?? "", confirmPassword: confirmPasswordContainer.getPassword() ?? "")
    }
        
    func showWarningMessagePassword() {
        passwordContainer.showWarning()
        confirmPasswordContainer.showWarning()
    }
    
    func hideWarningMessagePassword() {
        passwordContainer.hideWarning()
        confirmPasswordContainer.hideWarning()
    }
    
}
