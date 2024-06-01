//
//  EmptyStateView.swift
//  Kirala
//
//  Created by Ali Çolak on 15.05.2024.
//

import UIKit

/// View to display empty state information.
final class EmptyStateView: UIView, EmptyStateViewProtocol {
    
    // MARK: - Properties
    
    /// Delegate to handle output events.
    weak var delegate: EmptyStateViewDelegate?
    
    /// Current state of the empty state view.
    private var state: EmptyStateState = .hidden {
        didSet {
            switch state {
            case .hidden:
                isHidden = true
            case .visible:
                isHidden = false
            }
        }
    }
    
    /// Duration for the show/hide animations.
    private let animationDuration: TimeInterval = 0.6
    
    // MARK: - UI Components
    
    /// Circle view containing the image.
    private lazy var imageCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorBackground.secondary.dynamicColor
        view.layer.cornerRadius = 50
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Image view for the empty state.
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    /// Title label for the empty state.
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = ColorText.primary.dynamicColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Description label for the empty state.
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = ColorText.secondary.dynamicColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Action button for the empty state.
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorText.primary.dynamicColor
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
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
    
    // MARK: - Setup Layout
    
    /// Sets up the layout of the empty state view.
    private func setupLayout() {
        backgroundColor = .clear
        state = .hidden
        
        imageCircleView.addSubview(imageView)
        
        addSubviews([
            imageCircleView,
            titleLabel,
            descriptionLabel,
            actionButton
        ])
        
        NSLayoutConstraint.activate([
            imageCircleView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            imageCircleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageCircleView.widthAnchor.constraint(equalToConstant: 100),
            imageCircleView.heightAnchor.constraint(equalToConstant: 100),
            
            imageView.centerXAnchor.constraint(equalTo: imageCircleView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageCircleView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            imageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: imageCircleView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            actionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            actionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 250),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    // MARK: - EmptyStateViewProtocol
    
    func configure(with state: EmptyState) {
        let data = state.data
        imageView.image = data.image
        imageView.tintColor = data.imageTintColor
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        actionButton.setTitle(data.buttonTitle, for: .normal)
        actionButton.backgroundColor = data.buttonBackgroundColor
        actionButton.setTitleColor(data.buttonTitleColor, for: .normal)
    }
    
    func show(withAnimation: Bool = true) {
        if withAnimation {
            alpha = 0.0
            state = .visible
            UIView.animate(withDuration: animationDuration) {
                self.alpha = 1.0
            }
        } else {
            state = .visible
            alpha = 1.0
        }
    }
    
    func hide(withAnimation: Bool = true) {
        if withAnimation {
            UIView.animate(withDuration: animationDuration) {
                self.alpha = 0.0
            } completion: { _ in
                self.state = .hidden
            }
        } else {
            state = .hidden
            alpha = 0.0
        }
    }
    
    // MARK: - Actions
    
    @objc private func didTapButton() {
        state = .hidden
        delegate?.didTapActionButton()
    }
    
}
