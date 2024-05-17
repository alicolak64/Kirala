//
//  LoadingView.swift
//  Kirala
//
//  Created by Ali Çolak on 15.05.2024.
//

import UIKit

final class LoadingView: UIView, LoadingViewProtocol {
    
    // MARK: - Properties
    
    private var state: LoadingState = .loading {
        didSet {
            switch state {
            case .loading:
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.activityIndicator.startAnimating()
                }
            case .loaded:
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    // MARK: - UI Components
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = ColorPalette.black.color
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
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    // MARK: - Layout
    
    private func setupLayout() {
        addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    // MARK: - Delegate Methods
    
    func showLoading() {
        state = .loading
    }
    
    func hideLoading() {
        state = .loaded
    }
    
}

