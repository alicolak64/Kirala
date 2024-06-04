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
        delegate?.prepareResetPasswordCard()
        delegate?.prepareWarningCard()
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
    
    // MARK: - Actions
    
    func didTapCancelButton() {
        router.navigate(to: .back)
    }
    
    func didTapLoginButton() {
        cardState = .login
        delegate?.hideWarningCard(animated: false)
        delegate?.showLoginCard()
    }
    
    func didTapRegisterButton() {
        cardState = .register
        delegate?.hideWarningCard(animated: false)
        delegate?.showRegisterCard()
    }
    
    func didTapForgotPasswordButton() {
        cardState = .resetPassword
        delegate?.hideWarningCard(animated: false)
        delegate?.showResetPasswordCard()
    }
    
    func didTapLoginWithAppleButton() {
        switch cardState {
        case .login:
            print("Login with Apple")
        case .register:
            print("Register with Apple")
        case .resetPassword:
            break
        }
    }
    
    func didTapLoginWithGoogleButton() {
        switch cardState {
        case .login:
            guard let url = authenticationService.loginWithGoogle() else { return }
            router.navigate(to: .safari(url))
        case .register:
            guard let url = authenticationService.loginWithGoogle() else { return }
            router.navigate(to: .safari(url))
        case .resetPassword:
            break
        }
    }
    
    func didTapLoginButton(email: String, password: String) {
        guard email.isValidEmail else {
            delegate?.showWarningCard(with: Localization.auth.localizedString(for: "EMAIL_VALIDATION"), animated: true)
            delegate?.showWarninEmailField(type: cardState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.hideWarningCard(animated: true)
                self.delegate?.hideWarningEmailField(type: self.cardState)
            }
            return
        }
        
        guard password.isValidPassword else {
            delegate?.showWarningCard(with: Localization.auth.localizedString(for: "PASSWORD_VALIDATION"), animated: true)
            delegate?.showWarningPasswordField(type: cardState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.hideWarningCard(animated: true)
                self.delegate?.hideWarningPasswordField(type: self.cardState)
            }
            return
        }
        
        authenticationService.login(email: email, password: password) { result in
            switch result {
            case .success:
                print("Login success")
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.showWarningCard(with: error.serverResponse?.returnMessage ?? "Error", animated: true)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.delegate?.hideWarningCard(animated: true)
                }
            }
        }
        
    }
    
    func didTapRegisterButton(email: String, password: String) {
        guard email.isValidEmail else {
            delegate?.showWarningCard(with: Localization.auth.localizedString(for: "EMAIL_VALIDATION"), animated: true)
            delegate?.showWarninEmailField(type: cardState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.hideWarningCard(animated: true)
                self.delegate?.hideWarningEmailField(type: self.cardState)
            }
            return
        }
        
        guard password.isValidPassword else {
            delegate?.showWarningCard(with: Localization.auth.localizedString(for: "PASSWORD_VALIDATION"), animated: true)
            delegate?.showWarningPasswordField(type: cardState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.hideWarningCard(animated: true)
                self.delegate?.hideWarningPasswordField(type: self.cardState)
            }
            return
        }
        print("Register with \(email) and \(password)")
    }
    
    func didTapResetPasswordButton(email: String) {
        guard email.isValidEmail else {
            delegate?.showWarningCard(with: Localization.auth.localizedString(for: "EMAIL_VALIDATION"), animated: true)
            delegate?.showWarninEmailField(type: cardState)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.delegate?.hideWarningCard(animated: true)
                self.delegate?.hideWarningEmailField(type: self.cardState)
            }
            return
        }
        print("Reset password with \(email)")
    }
    
}
