//
//  ProductsOnSaleViewModel.swift
//  Sia
//
//  Created by Sandro Gelashvili on 20.07.24.
//

import Foundation
import Combine

class ProductsOnSaleViewModel: ObservableObject {
    @Published var store: Store
    @Published var saleProducts: [Product] = []
    
    private var firestoreManager: FirestoreManager
    private var cancellables = Set<AnyCancellable>()
    
    init(store: Store, firestoreManager: FirestoreManager = FirestoreManager()) {
        self.store = store
        self.firestoreManager = firestoreManager
        fetchSaleProducts()
    }
    
    private func fetchSaleProducts() {
        firestoreManager.fetchAllProducts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching products: \(error)")
                }
            }, receiveValue: { [weak self] products in
                self?.filterUniqueSaleProducts(products: products)
            })
            .store(in: &cancellables)
    }
    
    private func filterUniqueSaleProducts(products: [Product]) {
        var uniqueProducts = [String: Product]()
        products.forEach { product in
            if product.storeId == store.id && product.onDeal == true {
                let uniqueKey = "\(product.name)-\(product.storeId)"
                uniqueProducts[uniqueKey] = product
            }
        }
        saleProducts = Array(uniqueProducts.values)
    }
    
    func toggleFavorite(for product: Product) {
        var mutableProduct = product
        FavoritesManager.shared.toggleFavorite(product: &mutableProduct, allProducts: &saleProducts)
    }
}
