//
//  LoadingView.swift
//  Kirala
//
//  Created by Ali Çolak on 15.05.2024.
//

import UIKit

/// A view that displays a loading indicator.
final class LoadingView: UIView, LoadingViewProtocol {
    
    // MARK: - Properties
    
    /// The current state of the loading view.
    private var state: LoadingState = .loading {
        didSet {
            updateLoadingState()
        }
    }
    
    // MARK: - UI Components
    
    /// The activity indicator to show loading state.
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = ColorBackground.primary.color
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
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
        addSubview(activityIndicator)
        setupConstraints()
    }
    
    /// Sets up the constraints for the loading view.
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Methods
    
    /// Updates the loading state of the view.
    private func updateLoadingState() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch self.state {
            case .loading:
                self.activityIndicator.startAnimating()
            case .loaded:
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    // MARK: - LoadingViewProtocol
    
    func showLoading() {
        state = .loading
    }
    
    func hideLoading() {
        state = .loaded
    }
}
