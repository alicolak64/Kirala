//
//  SortPopupViewController.swift
//  Kirala
//
//  Created by Ali Çolak on 30.05.2024.
//

import UIKit

final class SortPopupView: BottomPopupViewController {
    
    // MARK: - Properties
    
    var presenter: SortPopupPresenterProtocol! {
        didSet {
            presenter.load()
        }
    }
    
    private var attributes: BottomPopupAttributes?
        
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorBackground.primary.dynamicColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seperator: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.border.dynamicColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - BottomPopupAttributesDelegate Variables
    override var popupHeight: CGFloat { attributes?.height ?? 300.0 }
    override var popupTopCornerRadius: CGFloat { attributes?.cornerRadius ?? 5.0 }
    override var popupPresentDuration: Double { attributes?.presentDuration ?? 1.0 }
    override var popupDismissDuration: Double { attributes?.dismissDuration ?? 1.0 }
    override var popupShouldDismissInteractivelty: Bool { attributes?.shouldDismissInteractivelty ?? true }
    override var popupDimmingViewAlpha: CGFloat { attributes?.dimmingViewAlpha ?? 0.5 }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
    }
    
    private func configureView() {
        view.backgroundColor = ColorBackground.primary.dynamicColor
        
        titleView.addSubviews([
            titleLabel,
            seperator
        ])
        
        view.addSubviews([
            titleView,
            tableView
        ])
        
        NSLayoutConstraint.activate([
            
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            
            
            seperator.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            seperator.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            seperator.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            seperator.heightAnchor.constraint(equalToConstant: 0.5),
            
            
            tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SelectCell.self)
    }
        
}

extension SortPopupView: SortPopupViewProtocol {
    
    
    func setAttributes(_ attributes: BottomPopupAttributes) {
        self.attributes = attributes
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func reloadRows(at indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SortPopupView: UITableViewDelegate, UITableViewDataSource {
    
    
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.heightForRow(at: indexPath)
    }
    
}
