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
    @Published var selectedStoreId: String? = nil
    
    private var firestoreManager = FirestoreManager()
    private var cancellables = Set<AnyCancellable>()
    
    init(firestoreManager: FirestoreManager = FirestoreManager()) {
        self.firestoreManager = firestoreManager
        setupBindings()
    }
    
    private func setupBindings() {
        firestoreManager.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                self?.categories = categories
            }
            .store(in: &cancellables)
        
        firestoreManager.$allProducts
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                self?.allProducts = products
                self?.filteredProducts = products
            }
            .store(in: &cancellables)

        firestoreManager.$stores
            .receive(on: DispatchQueue.main)
            .sink { [weak self] stores in
                self?.stores = stores
            }
            .store(in: &cancellables)
    }
    
    func fetchData() {
        firestoreManager.fetchCategories()
        firestoreManager.fetchStores()
        
        firestoreManager.fetchAllProducts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching products: \(error)")
                }
            }, receiveValue: { [weak self] products in
                self?.allProducts = products
                self?.filteredProducts = products
            })
            .store(in: &cancellables)
    }
    
    func search(query: String) {
        if query.isEmpty {
            if let storeId = selectedStoreId {
                filteredProducts = allProducts.filter { $0.storeId == storeId }
            } else {
                filteredProducts = allProducts
            }
        } else {
            if let storeId = selectedStoreId {
                filteredProducts = allProducts.filter { $0.name.contains(query) && $0.storeId == storeId }
            } else {
                filteredProducts = allProducts.filter { $0.name.contains(query) }
            }
        }
    }
}
