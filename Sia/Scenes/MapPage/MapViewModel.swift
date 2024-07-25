//
//  MapViewModel.swift
//  Sia
//
//  Created by Sandro Gelashvili on 25.07.24.
//

import Combine

class MapViewModel: ObservableObject {
    @Published var locations: [Location] = []
    private var firestoreManager = FirestoreManager()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchLocations() {
        firestoreManager.fetchLocations()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching locations: \(error)")
                }
            }, receiveValue: { [weak self] locations in
                self?.locations = locations
                print("Locations updated in ViewModel: \(locations.count)")
            })
            .store(in: &cancellables)
    }
}
