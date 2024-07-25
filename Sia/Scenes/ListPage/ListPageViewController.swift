//
//  ListPageViewController.swift
//  Sia
//
//  Created by Sandro Gelashvili on 12.07.24.
//

import UIKit

private enum ListPageConstants {
    static let cornerRadius: CGFloat = 5
    static let borderWidth: CGFloat = 0.5
    static let titleLabelFontSize: CGFloat = 24
    static let titleLabelTopPadding: CGFloat = 20
    static let titleLabelLeadingPadding: CGFloat = 20
    static let clearButtonTopPadding: CGFloat = 20
    static let clearButtonTrailingPadding: CGFloat = -20
    static let clearButtonWidth: CGFloat = 150
    static let collectionViewTopPadding: CGFloat = 20
    static let sectionHeaderHeight: CGFloat = 40
    static let itemHeight: CGFloat = 120
    static let sectionInset: CGFloat = 24
    static let minimumLineSpacing: CGFloat = 16
    static let collectionViewBottomPadding: CGFloat = 16
}

final class ListPageViewController: UIViewController {
    
    private let viewModel = ListPageViewModel.shared
    
    private var listTitleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.Listpage.title
        label.font = UIFont.boldSystemFont(ofSize: ListPageConstants.titleLabelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.Listpage.clearButton, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = ListPageConstants.cornerRadius
        button.layer.borderWidth = ListPageConstants.borderWidth
        button.layer.borderColor = UIColor.gray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: .zero, left: ListPageConstants.sectionInset, bottom: ListPageConstants.collectionViewBottomPadding, right: ListPageConstants.sectionInset)
        layout.minimumLineSpacing = ListPageConstants.minimumLineSpacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor .gray400UIKit
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
            listTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ListPageConstants.titleLabelTopPadding),
            listTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ListPageConstants.titleLabelLeadingPadding)
        ])
    }
    
    private func addClearButton() {
        view.addSubview(clearButton)
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: ListPageConstants.clearButtonTopPadding),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: ListPageConstants.clearButtonTrailingPadding),
            clearButton.widthAnchor.constraint(greaterThanOrEqualToConstant: ListPageConstants.clearButtonWidth)
        ])
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: listTitleLabel.bottomAnchor, constant: ListPageConstants.collectionViewTopPadding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        let storeName = viewModel.getStoreName(for: product.storeId)
        let storeImageUrl = viewModel.getStoreImageURL(for: product.storeId)
        cell.configure(with: product, storeName: storeName, storeImageUrl: storeImageUrl)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - (ListPageConstants.sectionInset * 2)
        return CGSize(width: width, height: ListPageConstants.itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: ListPageConstants.sectionHeaderHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
        
        let key = viewModel.keys[indexPath.section]
        let title = viewModel.getLocationName(for: key)
        headerView.configure(with: title)
        
        return headerView
    }
}


