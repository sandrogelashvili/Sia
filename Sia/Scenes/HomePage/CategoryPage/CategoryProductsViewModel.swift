//
//  CategoryProductsViewModel.swift
//  Sia
//
//  Created by Sandro Gelashvili on 13.07.24.
//

import Foundation
import Combine

class CategoryProductsViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var stores: [Store] = []
    let category: Category
    private var firestoreManager = FirestoreManager()
    private var cancellables = Set<AnyCancellable>()
    private let selectedStoreId: String?
    
    init(category: Category, selectedStoreId: String?) {
        self.category = category
        self.selectedStoreId = selectedStoreId
        fetchStoresAndProducts()
    }
    
    private func fetchStoresAndProducts() {
        firestoreManager.$stores
            .receive(on: DispatchQueue.main)
            .sink { [weak self] stores in
                self?.stores = stores
                self?.fetchProducts()
            }
            .store(in: &cancellables)
        
        firestoreManager.fetchStores()
    }
    
    private func fetchProducts() {
        firestoreManager.fetchAllProducts()
            .map { products in
                products.filter { $0.categoryId == self.category.categoryId }
            }
            .map { products in
                if let storeId = self.selectedStoreId {
                    return products.filter { $0.storeId == storeId }
                } else {
                    return products
                }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching products: \(error)")
                }
            }, receiveValue: { [weak self] products in
                self?.products = products
            })
            .store(in: &cancellables)
    }
    
    func getStoreName(for storeId: String) -> String {
        let storeName = stores.first { $0.id == storeId }?.name ?? ""
        return storeName
    }
    
    func getStoreImageURL(for storeId: String) -> String {
        let storeImageURL = stores.first { $0.id == storeId }?.storeImageURL ?? ""
        return storeImageURL
    }
}
