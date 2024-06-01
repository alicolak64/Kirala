//
//  AuthViewController.swift
//  Kirala
//
//  Created by Ali Çolak on 24.05.2024.
//

import UIKit

final class AuthViewController: UIViewController, SwipePerformable {
    
    // MARK: - Properties
    private let viewModel: AuthViewModel
    
    // MARK: - UI Properties
    
    private lazy var rightBackNavigationButton: UIBarButtonItem = {
        let backButton = UIButton(type: .custom)
        
        let backIcon = Symbols.multiply.symbol(size: 24)
        backButton.setImage(backIcon, for: .normal)
        backButton.tintColor = ColorPalette.white.dynamicColor
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backButtonItem = UIBarButtonItem(customView: backButton)
        return backButtonItem
    }()
    
    private lazy var leftBackNavigationButton: UIBarButtonItem = {
        let backButton = UIButton(type: .custom)
        
        let backIcon = Symbols.arrowLeft.symbol(size: 24)
        backButton.setImage(backIcon, for: .normal)
        backButton.tintColor = ColorPalette.white.dynamicColor
        
        backButton.addTarget(self, action: #selector(leftBackButtonTapped), for: .touchUpInside)
        
        let backButtonItem = UIBarButtonItem(customView: backButton)
        return backButtonItem
    }()
    
    private lazy var logoContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorPalette.appPrimary.dynamicColor
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = Images.logo.image
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var cartContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorPalette.white.dynamicColor
        return view
    }()
    
    private lazy var warningCard: WarningCard = {
        let view = WarningCard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginCard: LoginCard = {
        let view = LoginCard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var registerCard: RegisterCard = {
        let view = RegisterCard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var resetPasswordCard: ResetPasswordCard = {
        let view = ResetPasswordCard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var resetPasswordTipCard: ResetPasswordTipCard = {
        let view = ResetPasswordTipCard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.viewDidLayoutSubviews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        viewModel.didTapCancelButton()
    }
    
    @objc private func leftBackButtonTapped() {
        navigationItem.leftBarButtonItem = nil
        showLoginCard()
    }
    
}

extension AuthViewController: AuthViewProtocol {
    
    func prepareNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = rightBackNavigationButton
    }
    
    func prepareUI() {
        view.backgroundColor = ColorBackground.primary.dynamicColor
        
        logoContainer.addSubviews([
            logoImageView
        ])
        
        view.addSubviews([
            logoContainer,
            warningCard,
            cartContainer,
            loginCard,
            registerCard,
            resetPasswordCard,
            resetPasswordTipCard
        ])
        
    }
    
    func prepareConstraints() {
        
        NSLayoutConstraint.activate([
            
            logoContainer.topAnchor.constraint(equalTo: view.topAnchor),
            logoContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            logoContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35),
            
            logoImageView.centerXAnchor.constraint(equalTo: logoContainer.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: logoContainer.topAnchor, constant: 60),
            logoImageView.heightAnchor.constraint(equalTo: logoContainer.heightAnchor, multiplier: 0.2),
            
            cartContainer.topAnchor.constraint(equalTo: logoContainer.bottomAnchor),
            cartContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cartContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cartContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            warningCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningCard.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            warningCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            warningCard.heightAnchor.constraint(equalToConstant: 80),
            

            loginCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginCard.topAnchor.constraint(equalTo: warningCard.topAnchor, constant: 30),
            loginCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            loginCard.heightAnchor.constraint(equalToConstant: 400),
            
            registerCard.topAnchor.constraint(equalTo: warningCard.topAnchor, constant: 30),
            registerCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            registerCard.heightAnchor.constraint(equalToConstant: 550),
            
            resetPasswordCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetPasswordCard.topAnchor.constraint(equalTo: warningCard.topAnchor, constant: 30),
            resetPasswordCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            resetPasswordCard.heightAnchor.constraint(equalToConstant: 180),
            
            resetPasswordTipCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetPasswordTipCard.topAnchor.constraint(equalTo: resetPasswordCard.bottomAnchor, constant: 20),
            resetPasswordTipCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            resetPasswordTipCard.heightAnchor.constraint(equalToConstant: 120),
        ])
        
    }
    
    
    func addGestureRecognizers() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    
    func removeGestureRecognizers() {
        view.gestureRecognizers?.removeAll()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func prepareWarningCard() {
        warningCard.isHidden = true
    }
        
    func prepareLoginCard() {
        loginCard.delegate = self
        loginCard.isHidden = false
    }
    
    func prepareRegisterCard() {
        registerCard.delegate = self
        registerCard.isHidden = true
    }
    
    func prepareResetPasswordCard() {
        resetPasswordCard.delegate = self
        resetPasswordCard.isHidden = true
        resetPasswordTipCard.isHidden = true
    }
    
    func showLoginCard() {
        animateCardTransition(hideCards: [registerCard, resetPasswordCard, resetPasswordTipCard], showCards: [loginCard])
    }
    
    func showRegisterCard() {
        animateCardTransition(hideCards: [loginCard], showCards: [registerCard])
    }
    
    func showResetPasswordCard() {
        animateCardTransition(hideCards: [loginCard], showCards: [resetPasswordCard, resetPasswordTipCard])
        navigationItem.leftBarButtonItem = leftBackNavigationButton
    }
    
    func showWarningCard(with message: String, animated: Bool) {
        warningCard.showWarningMessage(message: message, animated: animated)
    }
    
    func hideWarningCard(animated: Bool) {
        warningCard.hideWarningMessage(animated: animated)
    }
    
    func showWarninEmailField(type: AuthCardState) {
        switch type {
        case .login:
            loginCard.showWarningMessageEmail()
        case .register:
            registerCard.showWarningMessageEmail()
        case .resetPassword:
            resetPasswordCard.showWarningMessageEmail()
        }
    }
    
    func hideWarningEmailField(type: AuthCardState) {
        switch type {
        case .login:
            loginCard.hideWarningMessageEmail()
        case .register:
            registerCard.hideWarningMessageEmail()
        case .resetPassword:
            resetPasswordCard.hideWarningMessageEmail()
        }
    }
    
    func showWarningPasswordField(type: AuthCardState) {
        switch type {
        case .login:
            loginCard.showWarningMessagePassword()
        case .register:
            registerCard.showWarningMessagePassword()
        case .resetPassword:
            break
        }
    }
    
    func hideWarningPasswordField(type: AuthCardState) {
        switch type {
        case .login:
            loginCard.hideWarningMessagePassword()
        case .register:
            registerCard.hideWarningMessagePassword()
        case .resetPassword:
            break
        }
    }
    
    private func animateCardTransition(hideCards: [UIView] = [], showCards: [UIView] = []) {
        let duration = 0.5
        let options: UIView.AnimationOptions = .transitionFlipFromLeft
        
        hideCards.forEach { hideCard in
            UIView.transition(with: hideCard, duration: duration, options: options, animations: {
                hideCard.isHidden = true
            }, completion: nil)
        }
        
        showCards.forEach { showCard in
            UIView.transition(with: showCard, duration: duration, options: options, animations: {
                showCard.isHidden = false
            }, completion: nil)
        }
    }


    
    
}

extension AuthViewController: LoginCardDelegate, RegisterCardDelegate, ResetPasswordCardDelegate {
    
    func didTapLoginButton() {
        viewModel.didTapLoginButton()
    }
    
    func didTapRegisterButton() {
        viewModel.didTapRegisterButton()
    }
    
    func didTapForgotPasswordButton() {
        viewModel.didTapForgotPasswordButton()
    }
    
    func didTapLoginWithAppleButton() {
        viewModel.didTapLoginWithAppleButton()
    }
    
    func didTapLoginWithGoogleButton() {
        viewModel.didTapLoginWithGoogleButton()
    }
    
    func didTapLoginButton(email: String, password: String) {
        viewModel.didTapLoginButton(email: email, password: password)
    }
    
    func didTapRegisterButton(email: String, password: String) {
        viewModel.didTapRegisterButton(email: email, password: password)
    }
    
    func didTapResetPasswordButton(email: String) {
        viewModel.didTapResetPasswordButton(email: email)
    }
        
}
