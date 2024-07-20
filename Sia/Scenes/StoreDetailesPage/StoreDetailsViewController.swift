//
//  StoreDetailsViewController.swift
//  Sia
//
//  Created by Sandro Gelashvili on 18.07.24.
//

import UIKit
import Combine

class StoreDetailsViewController: UIViewController {
    private var viewModel: StoreDetailsViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StoreDetailsTableViewCell.self, forCellReuseIdentifier: StoreDetailsTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    init(viewModel: StoreDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        setupTableHeaderView()
        addTableView()
    }
    
    private func setupTableHeaderView() {
        let headerView = StoreDetailsHeaderView(viewModel: viewModel)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 72)
        tableView.tableHeaderView = headerView
    }
    
    private func addTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func bindViewModel() {
        viewModel.$locations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

extension StoreDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoreDetailsTableViewCell.reuseIdentifier, for: indexPath) as! StoreDetailsTableViewCell
        let location = viewModel.locations[indexPath.row]
        cell.configure(with: location, mapButtonAction: { [weak self] in
            self?.viewModel.openMap(for: location)
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
