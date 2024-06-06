//
//  NameContainer.swift
//  Kirala
//
//  Created by Ali Çolak on 5.06.2024.
//

import UIKit

protocol NameContainerProtocol {
    func showWarning()
    func hideWarning()
    func getName() -> String?
}

final class NameContainer: UIView, NameContainerProtocol {
    
    // MARK: - Properties
    
    /// The current state of the loading view.
    private var state: ContainerState = .normal {
        didSet {
            updateContainerState()
        }
    }
    
    private lazy var nameTextField: AutoCompleteTextField = {
        let view = AutoCompleteTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.autoCompleteType = .none
        view.attributedPlaceholder = NSAttributedString(
            string: Strings.Auth.namePlaceholder.localized,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)
            ]
        )
        return view
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
        addBorder(width: 1, color: ColorPalette.border.dynamicColor)
        addCornerRadius(radius: 5)
        backgroundColor = ColorBackground.secondary.dynamicColor
        addSubview(nameTextField)
        setupConstraints()
    }
    
    /// Sets up the constraints for the loading view.
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 1),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1),
            nameTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
        ])
    }
    
    // MARK: - Methods
    
    /// Updates the loading state of the view.
    private func updateContainerState() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch self.state {
            case .normal:
                addRoundedBorder(width: 1, color: ColorPalette.border.dynamicColor)
                backgroundColor = ColorBackground.secondary.dynamicColor
            case .warning:
                addRoundedBorder(width: 1, color: ColorText.warning.dynamicColor)
                backgroundColor = ColorBackground.warning.dynamicColor
            }
        }
    }
    
    func showWarning() {
        state = .warning
    }
    
    func hideWarning() {
        state = .normal
    }
    
    func getName() -> String? {
        nameTextField.text
    }
    
}
