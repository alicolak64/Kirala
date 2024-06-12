//
//  AuthContracts.swift
//  Kirala
//
//  Created by Ali Çolak on 24.05.2024.
//

import UIKit

enum AuthCardState {
    case login
    case register
    case forgotPassword
    case resetPassword
}

protocol AuthBuilderProtocol {
    static func build(rootViewController: UIViewController?, navigationController: UINavigationController?) -> UIViewController
}

enum AuthRoute {
    case back
    case loginSuccess
    case safari(URL)
}

protocol AuthRouterProtocol {
    func navigate(to route: AuthRoute)
}

protocol AuthViewModelProtocol {
    
    // MARK: Dependency Properties
    var delegate: AuthViewProtocol? { get set }
    
    // MARK: Lifecycle Methods
    
    func viewDidLoad()
    func viewWillAppear()
    func viewDidLayoutSubviews()
    func viewDidAppear()
    func viewDidDisappear()
        
    // MARK: Actions
    func didTapCancelButton()
    func didTapLoginButton()
    func didTapRegisterButton()
    func didTapForgotPasswordButton()
    func didTapLoginWithAppleButton()
    func didTapLoginWithGoogleButton()
    func didTapLoginButton(email: String, password: String)
    func didTapRegisterButton(name: String, email: String, password: String)
    func didTapForgotPasswordButton(email: String)
    func didTapResetPasswordButton(password: String, confirmPassword: String)
    func didTapEmptyStateActionButton()
    
}


protocol AuthViewProtocol: AnyObject {
    
    // MARK: Methods
    
    func prepareNavigationBar()
    func prepareUI()
    func prepareConstraints()
    func prepareLoginCard()
    func prepareRegisterCard()
    func prepareForgotPasswordCard()
    func prepareWarningCard()
    func prepareResetPasswordCard()
    func addGestureRecognizers()
    func showLoginCard()
    func showRegisterCard()
    func showForgotPasswordCard()
    func showResetPasswordCard()
    func showWarningCard(with message: String, animated: Bool)
    func hideWarningCard(animated: Bool)
    func showWarningNameField(type: AuthCardState)
    func hideWarningNameField(type: AuthCardState)
    func showWarninEmailField(type: AuthCardState)
    func hideWarningEmailField(type: AuthCardState)
    func showWarningPasswordField(type: AuthCardState)
    func hideWarningPasswordField(type: AuthCardState)
    func showEmptyState(type: EmptyState)
    func removeGestureRecognizers()
    func addSwipeGesture()
    func removeSwipeGesture()    
    func showAlert(with alertMessage: AlertMessage, completion: @escaping () -> Void)
    func showAlert(with alertMessage: AlertMessage)
    func showLoading()
    func hideLoading(loadResult: LoadingResult)
    func closeKeyboard()
    
    func showActionSheet(title: String, message: String, actionTitle: String, completion: @escaping () -> Void)
    
}

