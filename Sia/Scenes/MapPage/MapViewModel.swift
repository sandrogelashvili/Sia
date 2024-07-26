//
//  MapViewModel.swift
//  Sia
//
//  Created by Sandro Gelashvili on 25.07.24.
//

import Combine
import FirebaseFirestore

final class MapViewModel: ObservableObject {
    @Published var locations: [Location] = []
    @Published var stores: [Store] = []
    @Published var errorMessage: String? = nil
    private var firestoreManager = FirestoreManager()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchStoresAndLocations() {
        let storesPublisher = Future<[Store], Error> { promise in
            self.firestoreManager.fetchStores { result in
                switch result {
                case .success(let stores):
                    promise(.success(stores))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        
        let locationsPublisher = firestoreManager.fetchLocations()
        
        Publishers.Zip(storesPublisher, locationsPublisher)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = "Error fetching data: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] stores, locations in
                self?.stores = stores
                self?.locations = locations
            })
            .store(in: &cancellables)
    }

    func findLocationsByStoreName(_ name: String) -> [Location] {
        let matchedStores = stores.filter { $0.name.localizedCaseInsensitiveContains(name) }
        let matchedStoreIds = matchedStores.compactMap { $0.id }
        return locations.filter { matchedStoreIds.contains($0.storeId) }
    }
}
