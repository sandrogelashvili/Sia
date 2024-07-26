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
    @Published var stores: [Store] = []
    @Published var selectedStoreId: String? = nil
    @Published var selectedPriceSortOption: PriceSortOption? = nil
    
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
        
        firestoreManager.$stores
            .receive(on: DispatchQueue.main)
            .assign(to: \.stores, on: self)
            .store(in: &cancellables)
    }
    
    private func fetchData() {
        firestoreManager.fetchCategories()
        firestoreManager.fetchStores()
    }
}
