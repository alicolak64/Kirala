//
//  ResetPasswordCard.swift
//  Kirala
//
//  Created by Ali Çolak on 25.05.2024.
//

import UIKit

protocol ResetPasswordCardDelegate: AnyObject {
    func didTapResetPasswordButton(email: String)
}

protocol ResetPasswordCardProtocol {
    var delegate: ResetPasswordCardDelegate? { get set }
    func showWarningMessageEmail()
    func hideWarningMessageEmail()
}

final class ResetPasswordCard: UIView, ResetPasswordCardProtocol {
    
    
    weak var delegate: ResetPasswordCardDelegate?
    
    // MARK: - UI Components
    
    private lazy var resetPasswordTipLabel: UILabel = {
        let label = UILabel()
        label.text = Localization.auth.localizedString(for: "RESET_PASSWORD_TIP")
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
    
    private lazy var resetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.auth.localizedString(for: "RESET_PASSWORD"), for: .normal)
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
            emailContainer,
            resetPasswordButton
        ])
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            resetPasswordTipLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            resetPasswordTipLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            resetPasswordTipLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            emailContainer.topAnchor.constraint(equalTo: resetPasswordTipLabel.bottomAnchor, constant: 16),
            emailContainer.leadingAnchor.constraint(equalTo: resetPasswordTipLabel.leadingAnchor),
            emailContainer.trailingAnchor.constraint(equalTo: resetPasswordTipLabel.trailingAnchor),
            emailContainer.heightAnchor.constraint(equalToConstant: 40),

            resetPasswordButton.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: 16),
            resetPasswordButton.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor),
            resetPasswordButton.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor),
            resetPasswordButton.heightAnchor.constraint(equalTo: emailContainer.heightAnchor),
            
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapResetPasswordButton() {
        delegate?.didTapResetPasswordButton(email: emailContainer.getEmail() ?? "")
    }
        
    func showWarningMessageEmail() {
        emailContainer.showWarning()
    }
    
    func hideWarningMessageEmail() {
        emailContainer.hideWarning()
    }
    
}
