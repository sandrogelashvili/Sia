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
                print("Initial Products: \(products)")
            }
            .store(in: &cancellables)
    }
    
    func fetchData() {
        firestoreManager.fetchCategories()
        firestoreManager.fetchAllProducts()
    }
    
    func search(query: String) {
        if query.isEmpty {
            filteredProducts = []
        } else {
            filteredProducts = allProducts.filter { $0.name.contains(query) }
        }
        print("Filtered Products: \(filteredProducts)")
    }
}
