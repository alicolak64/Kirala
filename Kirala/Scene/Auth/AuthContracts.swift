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
    case resetPassword
}

protocol AuthBuilderProtocol {
    static func build(rootNavigationController: UINavigationController?, navigationController: UINavigationController?) -> UIViewController
}

enum AuthRoute {
    case back
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
    func didTapRegisterButton(email: String, password: String)
    func didTapResetPasswordButton(email: String)
    
}


protocol AuthViewProtocol: AnyObject {
    
    // MARK: Methods
    
    func prepareNavigationBar()
    func prepareUI()
    func prepareConstraints()
    func prepareLoginCard()
    func prepareRegisterCard()
    func prepareResetPasswordCard()
    func prepareWarningCard()
    func addGestureRecognizers()
    func showLoginCard()
    func showRegisterCard()
    func showResetPasswordCard()
    func showWarningCard(with message: String, animated: Bool)
    func hideWarningCard(animated: Bool)
    func showWarninEmailField(type: AuthCardState)
    func hideWarningEmailField(type: AuthCardState)
    func showWarningPasswordField(type: AuthCardState)
    func hideWarningPasswordField(type: AuthCardState)
    func removeGestureRecognizers()
    func addSwipeGesture()
    func removeSwipeGesture()    
    
}

