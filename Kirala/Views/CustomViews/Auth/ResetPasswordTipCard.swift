//
//  ResetPasswordTipCard.swift
//  Kirala
//
//  Created by Ali Çolak on 25.05.2024.
//

import UIKit

final class ResetPasswordTipCard: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Localization.auth.localizedString(for: "RESET_PASSWORD_TIP_TITLE")
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textColor = ColorPalette.black.color
        return label
    }()
    
    private lazy var tipLabel1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Localization.auth.localizedString(for: "RESET_PASSWORD_TIP_1")
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = ColorPalette.gray.dynamicColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tipLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Localization.auth.localizedString(for: "RESET_PASSWORD_TIP_2")
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = ColorPalette.gray.dynamicColor
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tipLabel3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Localization.auth.localizedString(for: "RESET_PASSWORD_TIP_3")
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = ColorPalette.gray.dynamicColor
        label.numberOfLines = 0
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
        
        addSubviews([
            titleLabel,
            tipLabel1,
            tipLabel2,
            tipLabel3
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            tipLabel1.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            tipLabel1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            tipLabel1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            tipLabel2.topAnchor.constraint(equalTo: tipLabel1.bottomAnchor, constant: 8),
            tipLabel2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            tipLabel2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            tipLabel3.topAnchor.constraint(equalTo: tipLabel2.bottomAnchor, constant: 8),
            tipLabel3.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            tipLabel3.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            tipLabel3.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
}
