//
//  AdsViewController.swift
//  Kirala
//
//  Created by Ali Çolak on 6.06.2024.
//

import UIKit

final class AdsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: AdsViewModel
    
    // MARK: - UI Properties
    
    private lazy var emptyCardView: EmptyStateView = {
        let view = EmptyStateView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addAdButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: Symbols.plusCircleFill.symbol(),
            style: .plain,
            target: self,
            action: #selector(addAdButtonTapped)
        )
        button.tintColor = ColorPalette.appPrimary.dynamicColor
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = ColorPalette.appPrimary.dynamicColor
        return refreshControl
    }()
    
    // MARK: - Initializers
    init(viewModel: AdsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewDidAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewModel.viewDidLayoutSubviews()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    // MARK: - Actions
    
    @objc private func refreshControlPulled() {
        viewModel.refresh()
    }
    
}

extension AdsViewController: AdsViewProtocol {
    
    func prepareNavigationBar() {
        navigationItem.hidesBackButton = true
        addBottomBorder()
        navigationItem.title = Strings.Ad.myAds.localized
    }
    
    func addAddAdButtonNavigationItem() {
        navigationItem.rightBarButtonItem = addAdButton
    }
    
    func prepareUI() {
        view.backgroundColor = ColorBackground.primary.dynamicColor
        view.addSubviews([
            emptyCardView,
            loadingView
        ])
    }
    
    func prepareConstraints() {
        NSLayoutConstraint.activate([
            
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emptyCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIDevice.deviceHeight * 0.2),
            emptyCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emptyCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emptyCardView.heightAnchor.constraint(equalToConstant: UIDevice.deviceHeight * 0.3)
        ])
    }
    
    func prepareTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AdCell.self)
        
    }
    
    func showEmptyState(with state: EmptyState) {
        emptyCardView.configure(with: state)
        emptyCardView.show()
    }
    
    @objc private func addAdButtonTapped() {
        viewModel.didTapAddAdButton()
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func reloadRows(at indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
    
    func showLoading() {
        loadingView.showLoading()
    }
    
    func hideLoading(loadResult: LoadingResult) {
        loadingView.hideLoading(loadResult: loadResult)
    }
    
    func addRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
}

extension AdsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let arguments = viewModel.cellForRow(at: indexPath) else {
            return UITableViewCell()
        }
        
        let cell: AdCell = tableView.dequeueReusableCell(for: indexPath)
        let presenter = AdCellPresenter(view: cell, arguments: arguments)
        cell.presenter = presenter
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.heightForRow(at: indexPath)
    }
    
    
}

extension AdsViewController: EmptyStateViewDelegate {
    

    func didTapActionButton() {
        viewModel.didTapEmptyStateActionButton()
    }
    
}

