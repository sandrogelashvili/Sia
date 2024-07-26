//
//  StoresPageViewController.swift
//  Sia
//
//  Created by Sandro Gelashvili on 14.07.24.
//

import UIKit
import Combine
import SwiftUI

private enum Constants {
    static let collectionViewItemHeight: CGFloat = 280
}

final class StoresPageViewController: UIViewController {
    
    private let viewModel = StoresPageViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: Grid.Spacing.l,
                                           left: Grid.Spacing.xl,
                                           bottom: Grid.Spacing.l,
                                           right: Grid.Spacing.xl)
        layout.minimumLineSpacing = Grid.Spacing.m
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        setupCollectionView()
        bindViewModel()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StoreCollectionViewCell.self, forCellWithReuseIdentifier: StoreCollectionViewCell.reuseIdentifier)
    }
    
    private func bindViewModel() {
        viewModel.$stores
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$deals
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func presentStoreDetails(for store: Store) {
        let locations = viewModel.getLocations(for: store.id ?? "")
        let storeDetailsViewModel = StoreDetailsViewModel(store: store, locations: locations)
        let storeDetailsVC = StoreDetailsViewController(viewModel: storeDetailsViewModel)
        storeDetailsVC.modalPresentationStyle = .pageSheet
        if let sheet = storeDetailsVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(storeDetailsVC, animated: true, completion: nil)
    }
    
    private func presentProductsOnSale(for store: Store) {
        let productsOnSaleViewModel = ProductsOnSaleViewModel(store: store)
        let productsOnSaleView = ProductsOnSaleView(viewModel: productsOnSaleViewModel)
        let hostingController = UIHostingController(rootView: productsOnSaleView)
        hostingController.modalPresentationStyle = .pageSheet
        if let sheet = hostingController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(hostingController, animated: true, completion: nil)
    }
}

extension StoresPageViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.stores.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoreCollectionViewCell.reuseIdentifier, for: indexPath) as! StoreCollectionViewCell
        let store = viewModel.stores[indexPath.item]
        let deal = viewModel.deals.first { $0.storeId == store.id }
        cell.configure(with: store, dealBannerUrl: deal?.dealsImageURL ?? "")
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - Grid.Spacing.xl5
        return CGSize(width: width, height: Constants.collectionViewItemHeight)
    }
}

extension StoresPageViewController: StoreCollectionViewCellDelegate {
    func didTapStoreCell(store: Store) {
        presentStoreDetails(for: store)
    }
    
    func didTapBanner(for store: Store) {
        presentProductsOnSale(for: store)
    }
}
