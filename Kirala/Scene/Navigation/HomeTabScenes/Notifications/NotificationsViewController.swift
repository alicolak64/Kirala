//
//  NotificationsViewController.swift
//  Kirala
//
//  Created by Ali Çolak on 17.05.2024.
//

import UIKit

final class NotificationsViewController: UIViewController, SwipePerformable, BackNavigatable {
    
    // MARK: - Properties
    private let viewModel: NotificationsViewModel
    
    // MARK: - UI Properties
    
    private lazy var emptyCardView: EmptyStateView = {
        let view = EmptyStateView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initializers
    init(viewModel: NotificationsViewModel) {
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
        
    func backButtonTapped() {
        viewModel.didTapCancelButton()
    }
    
}

extension NotificationsViewController: NotificationsViewProtocol {
    
    func prepareNavigationBar() {
        navigationItem.hidesBackButton = true
        addBackButton()
        addBottomBorder()
        navigationItem.title = Localization.common.localizedString(for: "NOTIFICATIONS")
    }
    
    func prepareUI() {
        view.backgroundColor = ColorBackground.primary.dynamicColor
        view.addSubview(emptyCardView)
    }
    
    func prepareConstraints() {
        NSLayoutConstraint.activate([
            emptyCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIDevice.deviceHeight * 0.2),
            emptyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emptyCardView.heightAnchor.constraint(equalToConstant: UIDevice.deviceHeight * 0.3)
        ])
    }
    
    func showEmptyState(with state: EmptyState) {
        emptyCardView.configure(with: state)
        emptyCardView.show()
    }
    
}

extension NotificationsViewController: EmptyStateViewDelegate {
    

    func didTapActionButton() {
        viewModel.didTapEmptyStateActionButton()
    }
    
}
