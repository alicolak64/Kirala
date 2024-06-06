//
//  AuthViewModel.swift
//  Kirala
//
//  Created by Ali Çolak on 24.05.2024.
//

import Foundation


final class AuthViewModel {
    
    // MARK: - Dependency Properties
    
    weak var delegate: AuthViewProtocol?
    
    private let router: AuthRouterProtocol
    private let authService: AuthService
    private let authenticationService: AuthenticationService
    
    private var cardState: AuthCardState = .login
    
    private var loadingState: LoadingState = .loading {
        didSet {
            switch loadingState {
            case .loading:
                delegate?.showLoading()
            case .loaded(let result):
                delegate?.hideLoading(loadResult: result)
            }
        }
    }
        
    // MARK: - Initializers
    
    init(router: AuthRouterProtocol, authService: AuthService, authenticationService: AuthenticationService) {
        self.router = router
        self.authService = authService
        self.authenticationService = authenticationService
    }
    
}

extension AuthViewModel: AuthViewModelProtocol {

    // MARK: - Lifecycle Methods
    
    func viewDidLoad() {
        delegate?.prepareNavigationBar()
        delegate?.prepareUI()
        delegate?.prepareLoginCard()
        delegate?.prepareRegisterCard()
        delegate?.prepareForgotPasswordCard()
        delegate?.prepareResetPasswordCard()
        delegate?.prepareWarningCard()
        checkResetPasswordToken()
        checkError()
    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidAppear() {
        delegate?.addSwipeGesture()
        delegate?.addGestureRecognizers()
    }
    
    func viewDidDisappear() {
        delegate?.removeSwipeGesture()
        delegate?.removeGestureRecognizers()
    }
    
    func viewDidLayoutSubviews() {
        delegate?.prepareConstraints()
    }
    
    private func checkResetPasswordToken() {
        if authService.isResetPasswordTokenAvailable {
            configureResetPasswardCard()
        }
    }
    
    private func checkError() {
        if authService.isErrorAvailable {
            configureErrorCard()
        }
    }
    
    private func configureResetPasswardCard() {
        cardState = .resetPassword
        delegate?.showResetPasswordCard()
    }
    
    private func configureErrorCard() {
        guard (authService.getError()) != nil else { return }
        delegate?.showEmptyState(type: .invalidOrExpireToken)
        DispatchQueue.global().async { [weak self] in
            self?.authService.removeError()
        }
    }
    
    func didTapEmptyStateActionButton() {
        delegate?.showLoginCard()
        delegate?.closeKeyboard()
    }
    
    // MARK: - Actions
    
    func didTapCancelButton() {
        delegate?.closeKeyboard()
        router.navigate(to: .back)
    }
    
    func didTapLoginButton() {
        delegate?.closeKeyboard()
        cardState = .login
        delegate?.hideWarningCard(animated: false)
        delegate?.showLoginCard()
    }
    
    func didTapRegisterButton() {
        delegate?.closeKeyboard()
        cardState = .register
        delegate?.hideWarningCard(animated: false)
        delegate?.showRegisterCard()
    }
    
    func didTapForgotPasswordButton() {
        delegate?.closeKeyboard()
        cardState = .forgotPassword
        delegate?.hideWarningCard(animated: false)
        delegate?.showForgotPasswordCard()
    }
    
    func didTapLoginWithAppleButton() {
        delegate?.closeKeyboard()
        switch cardState {
        case .login:
            print("Login with Apple")
        case .register:
            print("Register with Apple")
        case .forgotPassword, .resetPassword:
            break
        }
    }
    
    func didTapLoginWithGoogleButton() {
        delegate?.closeKeyboard()
        switch cardState {
        case .login:
            guard let url = authenticationService.loginWithGoogle() else { return }
            router.navigate(to: .safari(url))
        case .register:
            guard let url = authenticationService.loginWithGoogle() else { return }
            router.navigate(to: .safari(url))
        case .forgotPassword, .resetPassword:
            break
        }
    }
    
    func didTapLoginButton(email: String, password: String) {
        delegate?.closeKeyboard()
        guard email.isValidEmail else {
            delegate?.showWarningCard(with: Strings.Auth.emailValidation.localized, animated: true)
            delegate?.showWarninEmailField(type: cardState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.hideWarningCard(animated: true)
                self.delegate?.hideWarningEmailField(type: self.cardState)
            }
            return
        }
        
        guard password.isValidPassword else {
            delegate?.showWarningCard(with: Strings.Auth.passwordValidation.localized, animated: true)
            delegate?.showWarningPasswordField(type: cardState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.hideWarningCard(animated: true)
                self.delegate?.hideWarningPasswordField(type: self.cardState)
            }
            return
        }
        
        loadingState = .loading
        
        authenticationService.login(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    guard let data = response.data else { return }
                    self.loadingState = .loaded(.none)
                    self.authService.saveAuthToken(token: data.token)
                    self.authService.saveAuthTokenType(tokenType: data.tokenType)
                    self.router.navigate(to: .loginSuccess)
                case .failure(let error):
                    self.loadingState = .loaded(.none)
                    self.delegate?.showWarningCard(with: error.serverResponse?.returnMessage ?? Strings.Common.error.localized, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                        self?.delegate?.hideWarningCard(animated: true)
                    }
                }
            }
        }
        
    }
    
    func didTapRegisterButton(name: String, email: String, password: String) {
        delegate?.closeKeyboard()
        guard name.isValidName else {
            delegate?.showWarningCard(with: Strings.Auth.nameValidation.localized, animated: true)
            delegate?.showWarningNameField(type: cardState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.hideWarningCard(animated: true)
                self.delegate?.hideWarningNameField(type: self.cardState)
            }
            return
        }
        
        guard email.isValidEmail else {
            delegate?.showWarningCard(with: Strings.Auth.emailValidation.localized, animated: true)
            delegate?.showWarninEmailField(type: cardState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.hideWarningCard(animated: true)
                self.delegate?.hideWarningEmailField(type: self.cardState)
            }
            return
        }
        
        guard password.isValidPassword else {
            delegate?.showWarningCard(with: Strings.Auth.passwordValidation.localized, animated: true)
            delegate?.showWarningPasswordField(type: cardState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.hideWarningCard(animated: true)
                self.delegate?.hideWarningPasswordField(type: self.cardState)
            }
            return
        }
        
        loadingState = .loading
        
        authenticationService.register(name: name, email: email, password: password) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.loadingState = .loaded(.none)
                    self.delegate?.showAlert(
                        with: AlertMessage(
                            title: Strings.Alert.registerSuccess.localized,
                            message: Strings.Alert.registerSuccessMessage.localized,
                            actionTitle: Strings.Common.ok.localized
                        ),
                        completion: {
                            self.delegate?.showLoginCard()
                        }
                    )
                case .failure(let error):
                    self.loadingState = .loaded(.none)
                    self.delegate?.showWarningCard(with: error.serverResponse?.returnMessage ?? Strings.Common.error.localized, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.delegate?.hideWarningCard(animated: true)
                    }
                }
            }
        }
        
    }
    
    func didTapForgotPasswordButton(email: String) {
        delegate?.closeKeyboard()
        guard email.isValidEmail else {
            delegate?.showWarningCard(with: Strings.Auth.emailValidation.localized, animated: true)
            delegate?.showWarninEmailField(type: cardState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.hideWarningCard(animated: true)
                self.delegate?.hideWarningEmailField(type: self.cardState)
            }
            return
        }
        
        loadingState = .loading
        
        authenticationService.forgotPassword(email: email) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success:
                    self.loadingState = .loaded(.none)
                    self.delegate?.showAlert(with: AlertMessage(
                        title: Strings.Alert.forgotPasswordSuccess.localized,
                        message: Strings.Alert.forgotPasswordSuccessMessage.localized,
                        actionTitle: Strings.Common.ok.localized
                    ))
                case .failure(let error):
                    self.loadingState = .loaded(.none)
                    self.delegate?.showWarningCard(with: error.serverResponse?.returnMessage ?? Strings.Common.error.localized, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.delegate?.hideWarningCard(animated: true)
                    }
                }
            }
        }
        
    }
    
    func didTapResetPasswordButton(password: String, confirmPassword: String) {
        delegate?.closeKeyboard()
        guard let token = authService.getResetPasswordToken() else {
            self.delegate?.showAlert(with: AlertMessage(
                title: Strings.Alert.somethingWentWrong.localized,
                message: Strings.Alert.somethingWentWrongMessage.localized,
                actionTitle: Strings.Common.ok.localized
            ))
            return
        }
        
        guard password.isValidPassword || confirmPassword.isValidPassword else {
            delegate?.showWarningCard(with: Strings.Auth.passwordValidation.localized, animated: true)
            delegate?.showWarningPasswordField(type: cardState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.hideWarningCard(animated: true)
                self.delegate?.hideWarningPasswordField(type: self.cardState)
            }
            return
        }
        
        guard password == confirmPassword else {
            delegate?.showWarningCard(with: Strings.Auth.passwordMatchValidation.localized, animated: true)
            delegate?.showWarningPasswordField(type: cardState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.hideWarningCard(animated: true)
                self.delegate?.hideWarningPasswordField(type: self.cardState)
            }
            return
        }
        
        loadingState = .loading
        
        authenticationService.resetPassword(token: token, password: password) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success:
                    loadingState = .loaded(.none)
                    self.delegate?.showAlert(with: AlertMessage(
                        title: Strings.Alert.resetPasswordSuccess.localized,
                        message: Strings.Alert.resetPasswordSuccessMessage.localized,
                        actionTitle: Strings.Common.ok.localized
                    ))
                    self.delegate?.showLoginCard()
                    DispatchQueue.global().async { [weak self] in
                        self?.authService.removeResetPasswordToken()
                    }
                case .failure(let error):
                    loadingState = .loaded(.none)
                    self.delegate?.showWarningCard(with: error.serverResponse?.returnMessage ?? Strings.Common.error.localized, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.delegate?.hideWarningCard(animated: true)
                    }
                }
            }
        }
        
    }
    
}
