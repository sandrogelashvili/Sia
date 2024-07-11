//
//  FilterViewModel.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import Foundation
import Combine

class FilterViewModel: ObservableObject {
    @Published var stores: [Store] = []
    
    private var firestoreManager = FirestoreManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        firestoreManager.$stores
            .receive(on: DispatchQueue.main)
            .assign(to: \.stores, on: self)
            .store(in: &cancellables)
        
        firestoreManager.fetchStores()
    }
}
