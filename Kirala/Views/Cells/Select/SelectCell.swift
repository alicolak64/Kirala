//
//  SelectCell.swift
//  Kirala
//
//  Created by Ali Çolak on 30.05.2024.
//

import UIKit

/// Collection view cell for displaying a category.
final class SelectCell: UITableViewCell, ReusableView {
    
    // MARK: - Properties
    
    var presenter: SelectCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = ColorText.primary.dynamicColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var radioButton: RadioButton = {
        let button = RadioButton()
        button.setSymbolSize(17)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private lazy var topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.lightBorder.dynamicColor
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
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
        
        contentView.addSubviews([nameLabel, radioButton, topSeparator])
        
        NSLayoutConstraint.activate([
            
            topSeparator.topAnchor.constraint(equalTo: contentView.topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 0.5),
            
            radioButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            radioButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            radioButton.widthAnchor.constraint(equalToConstant: 24),
            radioButton.heightAnchor.constraint(equalToConstant: 24),
            
            nameLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
        
    }
    
}

extension SelectCell: SelectCellViewProtocol {
    
    func setNameLabel(_ name: String) {
        nameLabel.text = name
    }
    
    func prepareSingleSelectStyle() {
        radioButton.style = .circle
        topSeparator.isHidden = true
        radioButton.setSymbolSize(15)
    }
    
    func prepareMultipleSelectStyle() {
        radioButton.style = .checkmark
        topSeparator.isHidden = false
    }
    
    func setNonSelectedImage() {
        radioButton.setUncheckedImage()
    }
    
    func setSelectedImage() {
        radioButton.setCheckedImage()
    }
    
}
