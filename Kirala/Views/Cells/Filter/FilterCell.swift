//
//  Filter.swift
//  Kirala
//
//  Created by Ali Çolak on 30.05.2024.
//

import UIKit


final class FilterCell: UITableViewCell, ReusableView {
    
    // MARK: - Properties
    
    var presenter: FilterCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = ColorText.primary.dynamicColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var selectedItemCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = ColorPalette.appPrimary.dynamicColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private lazy var selectedItemsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = ColorText.quaternary.dynamicColor
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Symbols.chevronRight.symbol()
        imageView.tintColor = ColorPalette.appPrimary.dynamicColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.lightBorder.dynamicColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var nameLabelCenterYConstraint: NSLayoutConstraint!
    private var nameLabelTopConstraint: NSLayoutConstraint!
    private var selectedItemsLabelTopConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        selectedItemsLabel.text = nil
        selectedItemsLabel.isHidden = true
        selectedItemCountLabel.text = nil
        selectedItemCountLabel.isHidden = true
        updateConstraintsForSelectedItemsLabel(isVisible: false)
    }
    
    private func setupViews() {
        
        contentView.backgroundColor = ColorBackground.primary.dynamicColor
        
        contentView.addSubviews([nameLabel, selectedItemCountLabel, selectedItemsLabel, arrowImageView, topSeparator])
                
        nameLabelCenterYConstraint = nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        nameLabelTopConstraint = nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        selectedItemsLabelTopConstraint = selectedItemsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4)
        
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: contentView.topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 0.5),
            
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabelCenterYConstraint,
            
            selectedItemCountLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 2),
            selectedItemCountLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func updateConstraintsForSelectedItemsLabel(isVisible: Bool) {
        if isVisible {
            nameLabelCenterYConstraint.isActive = false
            contentView.addSubview(selectedItemsLabel)
            
            NSLayoutConstraint.activate([
                nameLabelTopConstraint,
                selectedItemsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                selectedItemsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
                selectedItemsLabelTopConstraint
            ])
        } else {
            NSLayoutConstraint.deactivate([nameLabelTopConstraint, selectedItemsLabelTopConstraint])
            selectedItemsLabel.removeFromSuperview()
            nameLabelCenterYConstraint.isActive = true
        }
    }
}

extension FilterCell: FilterCellViewProtocol {
    
    func setSelectedItemsLabel(_ selectedItemsText: String) {
        selectedItemsLabel.text = selectedItemsText
        selectedItemsLabel.isHidden = selectedItemsText == ""
        updateConstraintsForSelectedItemsLabel(isVisible: selectedItemsText != "")
    }
    
    func setSelectedItemsCountLabel(_ count: Int) {
        selectedItemCountLabel.text = "(\(count))"
        selectedItemCountLabel.isHidden = count == 0
    }
    
    func setNameLabel(_ name: String) {
        nameLabel.text = name
    }
}
