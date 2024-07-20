//
//  StoresPageViewModel.swift
//  Sia
//
//  Created by Sandro Gelashvili on 18.07.24.
//

import Foundation
import Combine

final class StoresPageViewModel: ObservableObject {
    @Published var stores: [Store] = []
    @Published var deals: [DealsAndOffers] = []
    private var locations: [Location] = []
    
    private var firestoreManager: FirestoreManager
    private var cancellables = Set<AnyCancellable>()
    
    init(firestoreManager: FirestoreManager = FirestoreManager()) {
        self.firestoreManager = firestoreManager
        fetchStoresAndDeals()
        fetchLocations()
    }
    
    private func fetchStoresAndDeals() {
        firestoreManager.fetchStores { [weak self] in
            self?.fetchDeals()
        }
        
        firestoreManager.$stores
            .receive(on: DispatchQueue.main)
            .sink { [weak self] stores in
                self?.stores = stores
            }
            .store(in: &cancellables)
        
        firestoreManager.$deals
            .receive(on: DispatchQueue.main)
            .sink { [weak self] deals in
                self?.deals = deals
            }
            .store(in: &cancellables)
    }
    
    private func fetchDeals() {
        firestoreManager.fetchDealsAndOffers()
    }
    
    private func fetchLocations() {
        firestoreManager.fetchLocations()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching locations: \(error)")
                }
            }, receiveValue: { [weak self] locations in
                self?.locations = locations
            })
            .store(in: &cancellables)
    }
    
    func getLocations(for storeId: String) -> [Location] {
        return locations.filter { $0.storeId == storeId }
    }
}
