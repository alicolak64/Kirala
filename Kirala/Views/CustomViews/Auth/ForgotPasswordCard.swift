//
//  ForgotPasswordCard.swift
//  Kirala
//
//  Created by Ali Çolak on 25.05.2024.
//

import UIKit

protocol ForgotPasswordCardDelegate: AnyObject {
    func didTapForgotPasswordButton(email: String)
}

protocol ForgotPasswordCardProtocol {
    var delegate: ForgotPasswordCardDelegate? { get set }
    func showWarningMessageEmail()
    func hideWarningMessageEmail()
}

final class ForgotPasswordCard: UIView, ForgotPasswordCardProtocol {
    
    
    weak var delegate: ForgotPasswordCardDelegate?
    
    // MARK: - UI Components
    
    private lazy var forgotPasswordTipLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Auth.forgotPasswordTip.localized
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.textColor = ColorText.primary.dynamicColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailContainer: EmailContainer = {
        let view = EmailContainer()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.Auth.resetPassword.localized, for: .normal)
        button.backgroundColor = ColorPalette.appPrimary.dynamicColor
        button.addTarget(self, action: #selector(didTapForgotPasswordButton), for: .touchUpInside)
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
            forgotPasswordTipLabel,
            emailContainer,
            forgotPasswordButton
        ])
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            forgotPasswordTipLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            forgotPasswordTipLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            forgotPasswordTipLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            emailContainer.topAnchor.constraint(equalTo: forgotPasswordTipLabel.bottomAnchor, constant: 16),
            emailContainer.leadingAnchor.constraint(equalTo: forgotPasswordTipLabel.leadingAnchor),
            emailContainer.trailingAnchor.constraint(equalTo: forgotPasswordTipLabel.trailingAnchor),
            emailContainer.heightAnchor.constraint(equalToConstant: 40),

            forgotPasswordButton.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: 16),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalTo: emailContainer.heightAnchor),
            
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapForgotPasswordButton() {
        delegate?.didTapForgotPasswordButton(email: emailContainer.getEmail() ?? "")
    }
        
    func showWarningMessageEmail() {
        emailContainer.showWarning()
    }
    
    func hideWarningMessageEmail() {
        emailContainer.hideWarning()
    }
    
}
