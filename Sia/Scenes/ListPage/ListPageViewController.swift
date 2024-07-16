//
//  ListPageViewController.swift
//  Sia
//
//  Created by Sandro Gelashvili on 12.07.24.
//

import UIKit

final class ListPageViewController: UIViewController {
    
    private let viewModel = ListPageViewModel.shared
    
    private var listTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "სია"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("სიის გასუფთავება", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 16, right: 24)
        layout.minimumLineSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "BackgroundColor")
        setUpUI()
        addActionForClearButton()
        addCollectionView()
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    private func refreshData() {
        viewModel.refreshData()
        collectionView.reloadData()
    }
    
    private func setUpUI() {
        addListTitleLabel()
        addClearButton()
    }
    
    private func addListTitleLabel() {
        view.addSubview(listTitleLabel)
        NSLayoutConstraint.activate([
            listTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            listTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    private func addClearButton() {
        view.addSubview(clearButton)
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            clearButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 150)
        ])
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: listTitleLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductListCell.self, forCellWithReuseIdentifier: ProductListCell.reuseIdentifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
    }
    
    private func addActionForClearButton() {
        clearButton.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel.clearFavorites()
            self?.refreshData()
        }), for: .touchUpInside)
    }
}

extension ListPageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let count = viewModel.keys.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = viewModel.keys[section]
        let rows = viewModel.productsGrouped[key]?.count ?? 0
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let key = viewModel.keys[indexPath.section]
        let products = viewModel.productsGrouped[key] ?? []
        let product = products[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductListCell.reuseIdentifier, for: indexPath) as! ProductListCell
        let storeName = viewModel.getStoreName(for: product.storeId)
        let storeImageUrl = viewModel.getStoreImageURL(for: product.storeId)
        cell.configure(with: product, storeName: storeName, storeImageUrl: storeImageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 48
        return CGSize(width: width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
        
        let key = viewModel.keys[indexPath.section]
        let title = viewModel.getLocationName(for: key)
        headerView.configure(with: title)
        
        return headerView
    }
}


