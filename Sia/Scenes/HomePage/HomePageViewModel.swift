//
//  HomePageViewModel.swift
//  Sia
//
//  Created by Sandro Gelashvili on 10.07.24.
//

import Foundation
import Combine

class HomePageViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var allProducts: [Product] = []
    @Published var filteredProducts: [Product] = []
    @Published var stores: [Store] = []
    @Published var groupedProducts: [String: [Product]] = [:]
    @Published var selectedStoreId: String? = nil
    
    private var firestoreManager: FirestoreManager
    private var cancellables = Set<AnyCancellable>()
    
    init(firestoreManager: FirestoreManager = FirestoreManager()) {
        self.firestoreManager = firestoreManager
        setupBindings()
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
                self?.groupProductsByLocation()
            }
            .store(in: &cancellables)

        firestoreManager.$stores
            .receive(on: DispatchQueue.main)
            .assign(to: \.stores, on: self)
            .store(in: &cancellables)
    }
    
    func fetchData() {
        firestoreManager.fetchCategories()
        firestoreManager.fetchStores()
        firestoreManager.fetchLocations()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching locations: \(error)")
                }
            }, receiveValue: { [weak self] _ in
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
                self?.groupProductsByLocation()
            })
            .store(in: &cancellables)
    }
    
    func search(query: String) {
        filteredProducts = allProducts.filter {
            $0.name.contains(query) && (selectedStoreId == nil || $0.storeId == selectedStoreId)
        }
        groupProductsByLocation()
    }
    
    private func groupProductsByLocation() {
        groupedProducts = Dictionary(grouping: filteredProducts) { product in
            firestoreManager.locations.first(where: { $0.id == product.locationId })?.address ?? ""
        }
    }
}
