//
//  MinMaxPopupView.swift
//  Kirala
//
//  Created by Ali Çolak on 2.06.2024.
//

import UIKit

final class MinMaxPopupView: BottomPopupViewController, BackNavigatable, Alertable {
    
    // MARK: - Properties
    
    var presenter: MinMaxPopupPresenterProtocol! {
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
        let button = UIBarButtonItem(title: Localization.filter.localizedString(for: "CLEAR").uppercased(), style: .plain, target: self, action: #selector(didTapClearButton))
        button.tintColor = ColorPalette.appPrimary.dynamicColor
        button.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14, weight: .semibold)], for: .normal)
        return button
    }()
    
    private lazy var minMaxView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorBackground.primary.dynamicColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var minTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Localization.filter.localizedString(for: "MIN")
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addBorder(width: 1, color: ColorPalette.border.dynamicColor)
        textField.addCornerRadius(radius: 10)
        textField.tag = MinMaxItemType.min.rawValue
        textField.delegate = self
        return textField
    }()
    
    private lazy var minMaxSeparator: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textColor = ColorPalette.border.dynamicColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var maxTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Localization.filter.localizedString(for: "MAX")
        textField.keyboardType = .decimalPad
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addBorder(width: 1, color: ColorPalette.border.dynamicColor)
        textField.addCornerRadius(radius: 10)
        textField.tag = MinMaxItemType.max.rawValue
        textField.delegate = self
        return textField
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
    
    override var popupHeight: CGFloat {  550.0 }
    
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
        view.backgroundColor = ColorBackground.secondary.dynamicColor
        navigationItem.hidesBackButton = true
        addBackButton()
        navigationItem.rightBarButtonItem = clearNavigationButton
        navigationItem.titleView = titleLabel
        
        view.addGestureRecognizer(tapGesture)
        
        footerView.addSubview(applyButton)
        
        minMaxView.addSubviews([
            minTextField,
            minMaxSeparator,
            maxTextField
        ])
        
        view.addSubviews([
            minMaxView,
            tableView,
            footerView
        ])
        
        NSLayoutConstraint.activate([
            
            minMaxView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            minMaxView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            minMaxView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            minMaxView.heightAnchor.constraint(equalToConstant: 60),
            
            minTextField.leadingAnchor.constraint(equalTo: minMaxView.leadingAnchor, constant: 10),
            minTextField.widthAnchor.constraint(equalTo: minMaxView.widthAnchor, multiplier: 0.4),
            minTextField.topAnchor.constraint(equalTo: minMaxView.topAnchor, constant: 10),
            minTextField.bottomAnchor.constraint(equalTo: minMaxView.bottomAnchor, constant: -10),
            
            minMaxSeparator.leadingAnchor.constraint(equalTo: minTextField.trailingAnchor, constant: 10),
            minMaxSeparator.centerYAnchor.constraint(equalTo: minMaxView.centerYAnchor),
            
            maxTextField.leadingAnchor.constraint(equalTo: minMaxSeparator.trailingAnchor, constant: 10),
            maxTextField.widthAnchor.constraint(equalTo: minMaxView.widthAnchor, multiplier: 0.4),
            maxTextField.topAnchor.constraint(equalTo: minMaxView.topAnchor, constant: 10),
            maxTextField.bottomAnchor.constraint(equalTo: minMaxView.bottomAnchor, constant: -10),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: minMaxView.bottomAnchor, constant: 10),
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
        presenter.didTapClearButton()
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

extension MinMaxPopupView: MinMaxPopupViewProtocol {
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func prepareForRatingView() {
        minMaxView.isHidden = true
    }
    
    func setMinTextFieldText(_ text: String) {
        minTextField.text = text
    }
    
    func setMaxTextFieldText(_ text: String) {
        maxTextField.text = text
    }
    
    func setClearButtonActive(_ isActive: Bool) {
        clearNavigationButton.isEnabled = isActive
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func reloadRows(at indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
    
    func showAlert(title: String, message: String) {
        showAlert(title: title, message: message, actions: [UIAlertAction(title: Localization.common.localizedString(for: "OK"), style: .default, handler: nil)])
    }
    
}

extension MinMaxPopupView: UITextFieldDelegate {
        
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.didEndEditingTextField(with: textField.text, type: MinMaxItemType(rawValue: textField.tag) ?? .min)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

extension MinMaxPopupView: UITableViewDelegate, UITableViewDataSource {
    
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
        let presenter = SelectCellPresenter(view: cell, arguments: arguments, type: .single)
        cell.presenter = presenter
        cell.showTopSeparator()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
    
}
