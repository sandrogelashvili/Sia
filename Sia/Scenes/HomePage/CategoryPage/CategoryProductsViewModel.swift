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
    @Published var groupedProducts: [String: [Product]] = [:]
    
    let category: Category
    private let selectedStoreId: String?
    private let firestoreManager = FirestoreManager()
    private var cancellables = Set<AnyCancellable>()
    
    init(category: Category, selectedStoreId: String?) {
        self.category = category
        self.selectedStoreId = selectedStoreId
        fetchStoresAndProducts()
    }
    
    private func fetchStoresAndProducts() {
        fetchStores()
        fetchLocations()
    }
    
    private func fetchStores() {
        firestoreManager.$stores
            .receive(on: DispatchQueue.main)
            .sink { [weak self] stores in
                self?.stores = stores
                self?.fetchProducts()
            }
            .store(in: &cancellables)
        
        firestoreManager.fetchStores()
    }
    
    private func fetchLocations() {
        firestoreManager.fetchLocations()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching locations: \(error)")
                }
            }, receiveValue: { [weak self] locations in
                self?.firestoreManager.locations = locations
                self?.fetchProducts()
            })
            .store(in: &cancellables)
    }
    
    private func fetchProducts() {
        firestoreManager.fetchAllProducts()
            .map { [weak self] products in
                self?.filterProducts(products) ?? []
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching products: \(error)")
                }
            }, receiveValue: { [weak self] products in
                self?.products = products
                self?.groupProductsByLocation()
            })
            .store(in: &cancellables)
    }
    
    private func filterProducts(_ products: [Product]) -> [Product] {
        var filteredProducts = products.filter { $0.categoryId == category.categoryId }
        if let storeId = selectedStoreId {
            filteredProducts = filteredProducts.filter { $0.storeId == storeId }
        }
        return filteredProducts
    }
    
    private func groupProductsByLocation() {
        guard !firestoreManager.locations.isEmpty else {
            return
        }
        var groupedDict = [String: [Product]]()
        for product in products {
            let locationId = product.locationId
            if let location = firestoreManager.locations.first(where: { $0.locationId == locationId }) {
                groupedDict[location.address, default: []].append(product)
            }
        }
        self.groupedProducts = groupedDict
    }
    
    func getStoreName(for storeId: String) -> String {
        return stores.first { $0.id == storeId }?.name ?? ""
    }
    
    func getStoreImageURL(for storeId: String) -> String {
        return stores.first { $0.id == storeId }?.storeImageURL ?? ""
    }
    
    func toggleFavorite(for product: Product) {
        var mutableProduct = product
        FavoritesManager.shared.toggleFavorite(product: &mutableProduct, allProducts: &products)
        groupProductsByLocation()
    }
}
