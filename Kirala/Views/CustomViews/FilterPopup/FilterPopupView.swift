//
//  FilterPopupViewController.swift
//  Kirala
//
//  Created by Ali Çolak on 30.05.2024.
//

import UIKit


import UIKit

final class FilterPopupView: BottomPopupViewController {
    
    // MARK: - Properties
    
    var presenter: FilterPopupPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    private var attributes: BottomPopupAttributes?
    
    private lazy var dismissButtonNavigationItem: UIBarButtonItem = {
        let button = UIBarButtonItem(image: Symbols.xmark.symbol(), style: .plain, target: self, action: #selector(didTapDismissButton))
        button.tintColor = ColorText.quaternary.dynamicColor
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
        
    private lazy var clearNavigationButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: Localization.filter.localizedString(for: "CLEAR"), style: .plain, target: self, action: #selector(didTapClearButton))
        button.tintColor = ColorPalette.appPrimary.dynamicColor
        return button
    }()
                
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView()
        view.makeFooterStyle()
        return view
    }()
        
    private lazy var listProductsButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.filter.localizedString(for: "LIST_PRODUCTS"), for: .normal)
        button.tintColor = ColorText.primary.dynamicColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = ColorPalette.appPrimary.dynamicColor
        button.addCornerRadius(radius: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapListProductsButton), for: .touchUpInside)
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
    }
    
    private func configureView() {
        view.backgroundColor = ColorBackground.primary.dynamicColor
        
        navigationItem.leftBarButtonItem = dismissButtonNavigationItem
        navigationItem.rightBarButtonItem = clearNavigationButton
        navigationItem.titleView = titleLabel
    
        footerView.addSubview(listProductsButton)

        
        view.addSubviews([
            tableView,
            footerView
        ])
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.12),
            
            listProductsButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10),
            listProductsButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            listProductsButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            listProductsButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor)
            
        ])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterCell.self)
    }
    
    // MARK: - Actions
    
    @objc private func didTapDismissButton() {
        presenter.didTapDismissButton()
    }
    
    @objc private func didTapClearButton() {
        presenter.didTapClearButton()
    }
    
    @objc private func didTapListProductsButton() {
        presenter.didTapListProductsButton()
    }
    
}

extension FilterPopupView: FilterPopupViewProtocol {
        
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func reloadRows(at indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
    
}

extension FilterPopupView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let arguments = presenter.cellForRow(at: indexPath) else {
            return UITableViewCell()
        }
        
        let cell: FilterCell = tableView.dequeueReusableCell(for: indexPath)
        let presenter = FilterCellPresenter(view: cell, arguments: arguments)
        cell.presenter = presenter
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
    
}
