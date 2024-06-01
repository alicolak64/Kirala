//
//  SearchablePopupView.swift
//  Kirala
//
//  Created by Ali Çolak on 31.05.2024.
//

import UIKit

final class SearchablePopupView: BottomPopupViewController, BackNavigatable {
    
    // MARK: - Properties
    
    var presenter: SearchablePopupPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
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
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.returnKeyType = .done
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
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
        
    private lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle(Localization.filter.localizedString(for: "APPLY"), for: .normal)
        button.tintColor = ColorText.primary.dynamicColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = ColorPalette.appPrimary.dynamicColor
        button.addCornerRadius(radius: 10)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapApplyButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
    }
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        gesture.cancelsTouchesInView = false
        return gesture
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
        dismissKeyboard()
    }
    
    // MARK: - Setup Methods
    
    private func configureView() {
        view.backgroundColor = ColorBackground.primary.dynamicColor
        navigationItem.hidesBackButton = true
        addBackButton()
        navigationItem.rightBarButtonItem = clearNavigationButton
        navigationItem.titleView = titleLabel
        
        view.addGestureRecognizer(tapGesture)
        
        footerView.addSubview(applyButton)

        view.addSubviews([
            searchBar,
            tableView,
            footerView
        ])
        
        NSLayoutConstraint.activate([
            
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
            footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.12),
            
            applyButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10),
            applyButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            applyButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20),
            applyButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor)
            
        ])
    }
        
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SelectCell.self)
    }
    
    // MARK: - Actions
    
    @objc private func didTapClearButton() {
        presenter.didTapClearOrSelectAllButton()
    }
    
    @objc private func didTapApplyButton() {
        presenter.didTapApplyButton()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func backButtonTapped() {
        presenter.didTapBackButton()
    }
    
}

extension SearchablePopupView: SearchablePopupViewProtocol {
    
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setSearchBarPlaceholder(_ placeholder: String) {
        searchBar.placeholder = placeholder
    }
    
    func setRightActionButtonTitle(_ title: String) {
        clearNavigationButton.title = title
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func reloadRows(at indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
    
}

extension SearchablePopupView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.textDidChange(searchText)
    }
    
}

extension SearchablePopupView: UITableViewDelegate, UITableViewDataSource {
    
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
        
        let cell: SelectCell = tableView.dequeueReusableCell(for: indexPath)
        let presenter = SelectCellPresenter(view: cell, arguments: arguments, type: .multiple)
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
