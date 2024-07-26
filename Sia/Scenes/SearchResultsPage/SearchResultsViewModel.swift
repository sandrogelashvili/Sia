//
//  SearchResultsViewModel.swift
//  Sia
//
//  Created by Sandro Gelashvili on 22.07.24.
//

import Foundation
import Combine

class SearchResultsViewModel: ObservableObject {
    @Published var allProducts: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var groupedSearchProducts: [String: [Product]] = [:]
    @Published var locations: [Location] = []
    @Published var stores: [Store] = []
    var selectedStoreId: String? = nil
    var selectedPriceSortOption: PriceSortOption? = nil
    
    private var firestoreManager: FirestoreManager
    private var cancellables = Set<AnyCancellable>()
    
    init(firestoreManager: FirestoreManager = FirestoreManager()) {
        self.firestoreManager = firestoreManager
        setupBindings()
        fetchData()
    }
    
    private func setupBindings() {
        firestoreManager.$allProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                self?.allProducts = products
                self?.applyFilters()
            }
            .store(in: &cancellables)
        
        firestoreManager.$locations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] locations in
                self?.locations = locations
                self?.applyFilters()
            }
            .store(in: &cancellables)
        
        firestoreManager.$stores
            .receive(on: DispatchQueue.main)
            .assign(to: \.stores, on: self)
            .store(in: &cancellables)
    }
    
    private func fetchData() {
        firestoreManager.fetchLocations()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching locations: \(error)")
                }
            }, receiveValue: { [weak self] locations in
                self?.locations = locations
                self?.fetchAllProducts()
            })
            .store(in: &cancellables)
        
        firestoreManager.fetchStores()
    }
    
    private func fetchAllProducts() {
        firestoreManager.fetchAllProducts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching products: \(error)")
                }
            }, receiveValue: { [weak self] products in
                self?.allProducts = products
                self?.applyFilters()
            })
            .store(in: &cancellables)
    }
    
    func search(query: String) {
        filteredProducts = allProducts.filter {
            $0.name.contains(query) && (selectedStoreId == nil || $0.storeId == selectedStoreId)
        }
        applyPriceSortOption()
        groupedSearchProductsByLocation()
    }
    
    private func applyFilters() {
        filteredProducts = allProducts.filter { product in
            (selectedStoreId == nil || product.storeId == selectedStoreId)
        }
        applyPriceSortOption()
        groupedSearchProductsByLocation()
    }
    
    private func applyPriceSortOption() {
        guard let selectedPriceSortOption = selectedPriceSortOption else { return }
        
        switch selectedPriceSortOption {
        case .lowToHigh:
            filteredProducts.sort { $0.price < $1.price }
        case .highToLow:
            filteredProducts.sort { $0.price > $1.price }
        }
    }
    
    private func groupedSearchProductsByLocation() {
        guard !locations.isEmpty else { return }
        var groupedDict = [String: [Product]]()
        for product in filteredProducts {
            if let location = locations.first(where: { $0.locationId == product.locationId }) {
                groupedDict[location.address, default: []].append(product)
            }
        }
        self.groupedSearchProducts = groupedDict
    }
    
    func getStoreName(for storeId: String) -> String {
        return stores.first { $0.id == storeId }?.name ?? ""
    }
    
    func getStoreImageURL(for storeId: String) -> String {
        return stores.first { $0.id == storeId }?.storeImageURL ?? ""
    }
    
    func toggleFavorite(for product: Product) {
        var mutableProduct = product
        FavoritesManager.shared.toggleFavorite(product: &mutableProduct, allProducts: &allProducts)
        applyFilters()
    }
}
