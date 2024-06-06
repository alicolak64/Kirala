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
    
    private lazy var forgotPasswordCard: ForgotPasswordCard = {
        let view = ForgotPasswordCard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var passwordTipCard: PasswordTipCard = {
        let view = PasswordTipCard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var resetPasswordCard: ResetPasswordCard = {
        let view = ResetPasswordCard()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emptyCardView: EmptyStateView = {
        let view = EmptyStateView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
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
            forgotPasswordCard,
            passwordTipCard,
            resetPasswordCard,
            emptyCardView,
            loadingView
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
            registerCard.heightAnchor.constraint(equalToConstant: UIDevice.deviceHeight > 700
                                                 ? UIDevice.deviceHeight * 0.7
                                                 : UIDevice.deviceHeight * 0.77),
                                    
            
            forgotPasswordCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forgotPasswordCard.topAnchor.constraint(equalTo: warningCard.topAnchor, constant: 30),
            forgotPasswordCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            forgotPasswordCard.heightAnchor.constraint(equalToConstant: 180),
            
            passwordTipCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTipCard.topAnchor.constraint(equalTo: forgotPasswordCard.bottomAnchor, constant: 20),
            passwordTipCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            passwordTipCard.heightAnchor.constraint(equalToConstant: 120),
            
            resetPasswordCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetPasswordCard.topAnchor.constraint(equalTo: warningCard.topAnchor, constant: 30),
            resetPasswordCard.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            resetPasswordCard.heightAnchor.constraint(equalToConstant: 300),
            
            emptyCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIDevice.deviceHeight * 0.2),
            emptyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emptyCardView.heightAnchor.constraint(equalToConstant: UIDevice.deviceHeight * 0.3),
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
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
    
    func prepareForgotPasswordCard() {
        forgotPasswordCard.delegate = self
        forgotPasswordCard.isHidden = true
        passwordTipCard.isHidden = true
    }
    
    func prepareResetPasswordCard() {
        resetPasswordCard.delegate = self
        resetPasswordCard.isHidden = true
    }
    
    func showLoginCard() {
        animateCardTransition(hideCards: [registerCard, forgotPasswordCard, passwordTipCard, resetPasswordCard, emptyCardView], showCards: [loginCard])
    }
    
    func showRegisterCard() {
        animateCardTransition(hideCards: [loginCard], showCards: [registerCard])
    }
    
    func showForgotPasswordCard() {
        animateCardTransition(hideCards: [loginCard], showCards: [forgotPasswordCard, passwordTipCard])
        navigationItem.leftBarButtonItem = leftBackNavigationButton
    }
    
    func showResetPasswordCard() {
        loginCard.isHidden = true
        registerCard.isHidden = true
        forgotPasswordCard.isHidden = true
        passwordTipCard.isHidden = true
        resetPasswordCard.isHidden = false
    }
    
    func showEmptyState(type: EmptyState) {
        loginCard.isHidden = true
        registerCard.isHidden = true
        forgotPasswordCard.isHidden = true
        passwordTipCard.isHidden = true
        resetPasswordCard.isHidden = true
        emptyCardView.configure(with: type)
        emptyCardView.isHidden = false
        emptyCardView.delegate = self
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
        case .forgotPassword:
            forgotPasswordCard.showWarningMessageEmail()
        case .resetPassword:
            break
        }
    }
    
    func hideWarningEmailField(type: AuthCardState) {
        switch type {
        case .login:
            loginCard.hideWarningMessageEmail()
        case .register:
            registerCard.hideWarningMessageEmail()
        case .forgotPassword:
            forgotPasswordCard.hideWarningMessageEmail()
        case .resetPassword:
            break
        }
    }
    
    func showWarningPasswordField(type: AuthCardState) {
        switch type {
        case .login:
            loginCard.showWarningMessagePassword()
        case .register:
            registerCard.showWarningMessagePassword()
        case .forgotPassword:
            break
        case .resetPassword:
            resetPasswordCard.showWarningMessagePassword()
        }
    }
    
    func hideWarningPasswordField(type: AuthCardState) {
        switch type {
        case .login:
            loginCard.hideWarningMessagePassword()
        case .register:
            registerCard.hideWarningMessagePassword()
        case .forgotPassword:
            break
        case .resetPassword:
            resetPasswordCard.hideWarningMessagePassword()
        }
    }
    
    func showWarningNameField(type: AuthCardState) {
        switch type {
        case .register:
            registerCard.showWarningMessageName()
        case .login, .forgotPassword, .resetPassword:
            break
        }
    }
    
    func hideWarningNameField(type: AuthCardState) {
        switch type {
        case .register:
            registerCard.hideWarningMessageName()
        case .login, .forgotPassword, .resetPassword:
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

    func showLoading() {
        loadingView.showLoading()
    }
    
    func hideLoading(loadResult: LoadingResult) {
        loadingView.hideLoading(loadResult: loadResult)
    }
    
    func closeKeyboard() {
        view.endEditing(true)
    }

    
    
}

extension AuthViewController: LoginCardDelegate, RegisterCardDelegate, ForgotPasswordCardDelegate, ResetPasswordCardDelegate {
    
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
    
    func didTapRegisterButton(name: String, email: String, password: String) {
        viewModel.didTapRegisterButton(name: name, email: email, password: password)
    }
    
    func didTapForgotPasswordButton(email: String) {
        viewModel.didTapForgotPasswordButton(email: email)
    }
    
    func didTapResetPasswordButton(password: String, confirmPassword: String) {
        viewModel.didTapResetPasswordButton(password: password, confirmPassword: confirmPassword)
    }
        
}

extension AuthViewController: Alertable {
        
    func showAlert(with alertMessage: AlertMessage) {
        showAlert(
            title: alertMessage.title,
            message: alertMessage.message,
            actions: [UIAlertAction(title: alertMessage.actionTitle, style: .default)]
        )
    }
    
    func showAlert(with alertMessage: AlertMessage, completion: @escaping () -> Void) {
        showAlert(
            title: alertMessage.title,
            message: alertMessage.message,
            actions: [UIAlertAction(title: alertMessage.actionTitle, style: .default) { _ in
                completion()
            }]
        )
    }
    
}

extension AuthViewController: EmptyStateViewDelegate {
    
    func didTapActionButton() {
        viewModel.didTapEmptyStateActionButton()
    }
    
}
