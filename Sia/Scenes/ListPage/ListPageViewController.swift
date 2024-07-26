//
//  ListPageViewController.swift
//  Sia
//
//  Created by Sandro Gelashvili on 12.07.24.
//

import UIKit

private enum Constants {
    static let titleLabelFontSize: CGFloat = 24
    static let placeholderViewLabelFontSize: CGFloat = 18
    static let clearButtonWidth: CGFloat = 150
    static let itemHeight: CGFloat = 120
    static let basketImageSize: CGFloat = 350
}

final class ListPageViewController: UIViewController {
    
    private let viewModel = ListPageViewModel.shared
    
    private var listTitleLabel: UILabel = {
        let label = UILabel()
        label.text = L10n.ListPage.title
        label.font = UIFont.boldSystemFont(ofSize: Constants.titleLabelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.ListPage.clearButton, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = Grid.CornerRadius.textField
        button.layer.borderWidth = Grid.BorderWidth.thin
        button.layer.borderColor = UIColor.gray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: .zero, left: Grid.Spacing.xl, bottom: Grid.Spacing.m, right: Grid.Spacing.xl)
        layout.minimumLineSpacing = Grid.Spacing.m
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    private let placeholderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        
        let imageView = UIImageView(image: UIImage .basketImage)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        let label = UILabel()
        label.text = L10n.ListPage.PlaceholderView.label
        label.font = UIFont.systemFont(ofSize: Constants.placeholderViewLabelFontSize)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -Grid.Spacing.l),
            imageView.widthAnchor.constraint(equalToConstant: Constants.basketImageSize),
            imageView.heightAnchor.constraint(equalToConstant: Constants.basketImageSize),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray400UIKit
        setUpUI()
        addActionForClearButton()
        addCollectionView()
        addPlaceholderView()
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshData()
    }
    
    private func refreshData() {
        viewModel.refreshData()
        collectionView.reloadData()
        updatePlaceholderVisibility()
    }
    
    private func setUpUI() {
        addListTitleLabel()
        addClearButton()
    }
    
    private func addListTitleLabel() {
        view.addSubview(listTitleLabel)
        NSLayoutConstraint.activate([
            listTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Grid.Spacing.l),
            listTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Grid.Spacing.l)
        ])
    }
    
    private func addClearButton() {
        view.addSubview(clearButton)
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Grid.Spacing.l),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Grid.Spacing.l),
            clearButton.widthAnchor.constraint(greaterThanOrEqualToConstant: Grid.Spacing.l)
        ])
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: listTitleLabel.bottomAnchor, constant: Grid.Spacing.l),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.reuseIdentifier)
    }
    
    private func addPlaceholderView() {
        view.addSubview(placeholderView)
        NSLayoutConstraint.activate([
            placeholderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            placeholderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            placeholderView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Grid.Spacing.l),
            placeholderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Grid.Spacing.l)
        ])
    }
    
    private func updatePlaceholderVisibility() {
        let hasProducts = !viewModel.productsGrouped.isEmpty
        collectionView.isHidden = !hasProducts
        placeholderView.isHidden = hasProducts
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
        let rows = viewModel.productsGrouped[key]?.count ?? .zero
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
        let width = collectionView.bounds.width - (Grid.Spacing.xl * 2)
        return CGSize(width: width, height: Constants.itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: Grid.Spacing.xl4)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as! SectionHeaderView
        
        let key = viewModel.keys[indexPath.section]
        let title = viewModel.getLocationName(for: key)
        headerView.configure(with: title)
        
        return headerView
    }
}


