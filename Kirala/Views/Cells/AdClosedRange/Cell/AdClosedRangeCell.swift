//
//  AdClosedRangeCell.swift
//  Kirala
//
//  Created by Ali Çolak on 9.06.2024.
//

import UIKit

final class AdClosedRangeCell: UITableViewCell, ReusableView {
    
    // MARK: - Properties
    
    var presenter: AdClosedRangeCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var placeholder: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = ColorText.quaternary.dynamicColor
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var closedRangeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addRoundedBorder(width: 1, color: ColorPalette.border.dynamicColor)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDateLabel)))
        return view
    }()
    
    private lazy var closedRangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = ColorText.primary.dynamicColor
        return label
    }()
    
    private lazy var trashButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Symbols.trash.symbol(size: 20), for: .normal)
        button.tintColor = ColorPalette.appPrimary.dynamicColor
        button.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.border.dynamicColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        
        closedRangeView.addSubviews([
            closedRangeLabel
        ])
        
        contentView.addSubviews([
            bottomSeparator,
            closedRangeView,
            trashButton
        ])
        
        NSLayoutConstraint.activate([
            
            closedRangeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            closedRangeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            closedRangeView.heightAnchor.constraint(equalToConstant: 60),
            closedRangeView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.7),
            
            closedRangeLabel.leadingAnchor.constraint(equalTo: closedRangeView.leadingAnchor, constant: 10),
            closedRangeLabel.trailingAnchor.constraint(equalTo: closedRangeView.trailingAnchor, constant: -10),
            closedRangeLabel.centerYAnchor.constraint(equalTo: closedRangeView.centerYAnchor),
            
            trashButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            trashButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            trashButton.widthAnchor.constraint(equalToConstant: 20),
            trashButton.heightAnchor.constraint(equalToConstant: 20),
            
            bottomSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bottomSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bottomSeparator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func resetUI() {
        [closedRangeView, trashButton, bottomSeparator].forEach {
            $0.isHidden = false
        }
        closedRangeLabel.text = ""
        placeholder.isHidden = true
    }
    
    @objc private func didTapDeleteButton() {
        presenter.didTapDeleteButton()
    }
    
    @objc private func didTapDateLabel() {
        presenter.didTapDateLabel()
    }
}

extension AdClosedRangeCell: AdClosedRangeCellViewProtocol {
    
    
    func setPlaceholder(_ title: String) {
        addSubview(placeholder)
        [closedRangeView, trashButton, bottomSeparator].forEach {
            $0.isHidden = true
        }
        placeholder.text = title
        placeholder.isHidden = false
    }
    
    func setDateLabel(_ date: String) {
        resetUI()
        closedRangeLabel.text = date
    }
    
    func showBottomSeparator() {
        bottomSeparator.isHidden = false
    }
    
    func hideBottomSeparator() {
        bottomSeparator.isHidden = true
    }
    
}
