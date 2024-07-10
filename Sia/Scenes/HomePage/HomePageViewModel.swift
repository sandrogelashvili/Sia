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
    
    private var firestoreManager = FirestoreManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        firestoreManager.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] categories in
                self?.categories = categories
            }
            .store(in: &cancellables)
        firestoreManager.fetchCategories()
    }
}
