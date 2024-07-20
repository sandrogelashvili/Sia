//
//  StoreDetailsViewModel.swift
//  Sia
//
//  Created by Sandro Gelashvili on 20.07.24.
//

import Combine
import Foundation
import UIKit

final class StoreDetailsViewModel: ObservableObject {
    @Published var storeImageURL: String = ""
    @Published var storeName: String = ""
    @Published var locations: [Location] = []
    
    init(store: Store, locations: [Location]) {
        self.storeImageURL = store.storeImageURL
        self.storeName = store.name
        self.locations = locations
    }
    
    func openMap(for location: Location) {
        if let url = URL(string: location.mapURL) {
            UIApplication.shared.open(url)
        }
    }
}
