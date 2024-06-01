//
//  CampaignCell.swift
//  Kirala
//
//  Created by Ali Çolak on 19.05.2024.
//

import UIKit
import Kingfisher

/// Collection view cell for displaying a campaign.
final class CampaignCell: UICollectionViewCell, ReusableView {
    
    // MARK: - Properties
    
    var presenter: CampaignCellPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    // MARK: - UI Components
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let countView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorBackground.quaternary.dynamicColor
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        return view
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        countView.addSubview(countLabel)
        contentView.addSubviews([imageView, countView])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            countView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            countView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            countView.heightAnchor.constraint(equalToConstant: 20),
            countView.widthAnchor.constraint(equalToConstant: 40),
            
            countLabel.centerXAnchor.constraint(equalTo: countView.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: countView.centerYAnchor)
        ])
    }
}

// MARK: - CampaignCellViewProtocol

extension CampaignCell: CampaignCellViewProtocol {
    func setImageURL(_ imageURL: URL) {
        imageView.kf.setImage(with: imageURL)
    }
    
    func setCountLabelText(_ text: String) {
        countLabel.text = text
    }
}
