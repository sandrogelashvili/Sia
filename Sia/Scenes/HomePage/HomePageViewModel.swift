//
//  HomePageViewModel.swift
//  Sia
//
//  Created by Sandro Gelashvili on 10.07.24.
//

// HomePageViewModel.swift

import Foundation
import Combine

class HomePageViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var allProducts: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var stores: [Store] = []
    @Published var groupedSearchProducts: [String: [Product]] = [:]
    @Published var selectedStoreId: String? = nil
    @Published var locations: [Location] = []
    
    private var firestoreManager: FirestoreManager
    private var cancellables = Set<AnyCancellable>()
    
    init(firestoreManager: FirestoreManager = FirestoreManager()) {
        self.firestoreManager = firestoreManager
        setupBindings()
        fetchData()
    }
    
    private func setupBindings() {
        firestoreManager.$categories
            .receive(on: DispatchQueue.main)
            .assign(to: \.categories, on: self)
            .store(in: &cancellables)
        
        firestoreManager.$allProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                self?.allProducts = products
                self?.filteredProducts = products
                self?.groupedSearchProductsByLocation()
            }
            .store(in: &cancellables)
        
        firestoreManager.$stores
            .receive(on: DispatchQueue.main)
            .assign(to: \.stores, on: self)
            .store(in: &cancellables)
        
        firestoreManager.$locations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] locations in
                self?.locations = locations
                self?.groupedSearchProductsByLocation()
            }
            .store(in: &cancellables)
    }
    
    private func fetchData() {
        firestoreManager.fetchCategories()
        firestoreManager.fetchStores()
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
                self?.filteredProducts = products
                self?.groupedSearchProductsByLocation()
            })
            .store(in: &cancellables)
    }
    
    func search(query: String) {
        filteredProducts = allProducts.filter {
            $0.name.contains(query) && (selectedStoreId == nil || $0.storeId == selectedStoreId)
        }
        groupedSearchProductsByLocation()
    }
    
    private func groupedSearchProductsByLocation() {
        guard !locations.isEmpty else {
            return
        }
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
}
