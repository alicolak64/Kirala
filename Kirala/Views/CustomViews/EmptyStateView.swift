//
//  EmptyStateView.swift
//  Kirala
//
//  Created by Ali Çolak on 15.05.2024.
//

import UIKit

enum EmptyState {
    case noData
    case noInternet
    case noSearchResult
    case noFavorites
    case emptyCart
    case noNotification
    case noOrder
    case unknown
    
    var data: EmptyStateProtocol {
        switch self {
        case .noData:
            return NoDataState()
        case .noInternet:
            return NoInternetState()
        case .noSearchResult:
            return NoSearchResultState()
        case .noFavorites:
            return NoFavoritesState()
        case .emptyCart:
            return EmptyCartState()
        case .noNotification:
            return NoNotificationState()
        case .noOrder:
            return NoOrderState()
        case .unknown:
            return UnknownState()
        }
    }
}

protocol EmptyStateProtocol {
    var image: UIImage? { get }
    var title: String { get }
    var description: String { get }
    var buttonTitle: String { get }
    var imageTintColor: UIColor { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

extension EmptyStateProtocol {
    var image: UIImage? { return Symbols.exclamationmark_triangle_fill.symbol() }
    var title: String { return Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_TITLE") }
    var description: String { return Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_DESC") }
    var buttonTitle: String { return Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_BUTTON") }
    var imageTintColor: UIColor { return ColorPalette.appMain.color }
    var buttonBackgroundColor: UIColor { return ColorPalette.appMain.color }
    var buttonTitleColor: UIColor { return ColorText.white.color }
}

struct NoDataState: EmptyStateProtocol {
    var image: UIImage? = Symbols.list_bullet_below_rectangle.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_DATA_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_DATA_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_DATA_BUTTON")
}

struct NoInternetState: EmptyStateProtocol {
    var image: UIImage? = Symbols.wifi_slash.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_INTERNET_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_INTERNET_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_INTERNET_BUTTON")
}

struct NoSearchResultState: EmptyStateProtocol {
    var image: UIImage? = Symbols.magnifyingglass_circle_fill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_SEARCH_RESULT_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_SEARCH_RESULT_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_SEARCH_RESULT_BUTTON")
}

struct NoFavoritesState: EmptyStateProtocol {
    var image: UIImage? = Symbols.star_slash_fill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_FAVORITE_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_FAVORITE_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_FAVORITE_BUTTON")
}

struct EmptyCartState: EmptyStateProtocol {
    var image: UIImage? = Symbols.cart_badge_minus.symbol()
    var title: String = Localization.emptyState.localizedString(for: "EMPTY_CART_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "EMPTY_CART_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "EMPTY_CART_BUTTON")
}

struct NoNotificationState: EmptyStateProtocol {
    var image: UIImage? = Symbols.bell_slash_fill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_NOTIFICATION_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_NOTIFICATION_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_NOTIFICATION_BUTTON")
}

struct NoOrderState: EmptyStateProtocol {
    var image: UIImage? = Symbols.rectangle_portrait_on_rectangle_portrait_slash_fill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "NO_ORDER_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "NO_ORDER_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "NO_ORDER_BUTTON")
}

struct UnknownState: EmptyStateProtocol {
    var image: UIImage? = Symbols.exclamationmark_triangle_fill.symbol()
    var title: String = Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_TITLE")
    var description: String = Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_DESC")
    var buttonTitle: String = Localization.emptyState.localizedString(for: "UNKNOWN_ERROR_BUTTON")
}


enum EmptyStateViewOutput {
    case didTapButton
}

protocol EmptyStateViewDelegate: AnyObject {
    func handleOutput(_ output: EmptyStateViewOutput)
}

enum EmptyStateState {
    case hidden
    case visible
}

protocol EmptyStateViewProtocol {
    var delegate: EmptyStateViewDelegate? { get set }
    func configure(with state: EmptyStateProtocol)
    func show(withAnimation: Bool)
    func hide(withAnimation: Bool)
}

final class EmptyStateView: UIView, EmptyStateViewProtocol {
    
    weak var delegate: EmptyStateViewDelegate?
    
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
    
    private let animationDuration: TimeInterval = 0.6
    
    private lazy var imageCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorBackground.tertiary.dynamicColor
        view.layer.cornerRadius = 50
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = ColorText.primary.dynamicColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = ColorText.secondary.dynamicColor
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = ColorText.primary.dynamicColor
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with state: EmptyStateProtocol) {
        imageView.image = state.image
        imageView.tintColor = state.imageTintColor
        titleLabel.text = state.title
        descriptionLabel.text = state.description
        actionButton.setTitle(state.buttonTitle, for: .normal)
        actionButton.backgroundColor = state.buttonBackgroundColor
        actionButton.setTitleColor(state.buttonTitleColor, for: .normal)
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
    
    @objc private func didTapButton() {
        print("Button Tapped")
        state = .hidden
        notify(.didTapButton)
    }
    
    private func notify(_ output: EmptyStateViewOutput) {
        delegate?.handleOutput(output)
    }
    
}

