//
//  AdImageCell.swift
//  Kirala
//
//  Created by Ali Çolak on 9.06.2024.
//

import UIKit
import Kingfisher

final class AdImageCell: UITableViewCell, ReusableView {
    
    // MARK: - Properties
    
    var presenter: AdImageCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var noImageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = ColorText.quaternary.dynamicColor
        label.isHidden = true
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var indexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = ColorText.primary.dynamicColor
        return label
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.addCornerRadius(radius: 8)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        
        contentView.addSubviews([
            bottomSeparator,
            indexLabel,
            image,
            trashButton,
        ])
        
        NSLayoutConstraint.activate([
            indexLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            indexLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            image.leadingAnchor.constraint(equalTo: indexLabel.trailingAnchor, constant: 16),
            image.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2),
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
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
        [indexLabel, image, trashButton, bottomSeparator].forEach {
            $0.isHidden = false
        }
        image.image = nil
        noImageLabel.isHidden = true
    }
    
    @objc private func didTapDeleteButton() {
        presenter.didTapDeleteButton()
    }
}

extension AdImageCell: AdImageCellViewProtocol {
    
    func setNoImageLabelTitle(_ title: String) {
        addSubview(noImageLabel)
        [indexLabel, image, trashButton, bottomSeparator].forEach {
            $0.isHidden = true
        }
        noImageLabel.text = title
        noImageLabel.isHidden = false
    }
    
    func setIndex(_ index: Int) {
        resetUI()
        indexLabel.text = "\(index)"
    }
    
    func setImageView(with image: UIImage) {
        self.image.image = image
    }
    
    func setImageURL(with imageUrl: URL) {
        image.kf.setImage(with: imageUrl)
    }
    
    func showBottomSeparator() {
        bottomSeparator.isHidden = false
    }
    
    func hideBottomSeparator() {
        bottomSeparator.isHidden = true
    }
    
}

