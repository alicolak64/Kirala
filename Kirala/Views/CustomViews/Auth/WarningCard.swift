//
//  WarningCard.swift
//  Kirala
//
//  Created by Ali Çolak on 25.05.2024.
//

import UIKit

protocol WarningCardProtocol {
    func showWarningMessage(message: String, animated: Bool)
    func hideWarningMessage(animated: Bool)
}

final class WarningCard: UIView, WarningCardProtocol {
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.Auth.forgotPasswordTipTitle.localized
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textColor = ColorText.warning.color
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        makeCardStyle()
        backgroundColor = ColorBackground.warning.dynamicColor
        
        addSubviews([
            messageLabel
        ])
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func showWarningMessage(message: String, animated: Bool) {
        
        let with = message.nsString.width(usingFont: messageLabel.font)
        
        if with > frame.width {
            let assumedFont = messageLabel.font.withSize(messageLabel.font.pointSize - 1)
            messageLabel.font = assumedFont
        }
        
        if animated {
            alpha = 0
            isHidden = false
            messageLabel.text = message
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.alpha = 1
                
            }
        } else {
            messageLabel.text = message
            isHidden = false
        }
        
    }
    
    func hideWarningMessage(animated: Bool) {
        
        if animated {
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.alpha = 0
            } completion: { [weak self] _ in
                self?.isHidden = true
            }
        } else {
            isHidden = true
        }
        
    }
    
}
