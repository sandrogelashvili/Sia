//
//  ListPageViewModel.swift
//  Sia
//
//  Created by Sandro Gelashvili on 15.07.24.
//

import Foundation

final class ListPageViewModel {
    static let shared = ListPageViewModel()
    private(set) var favoriteProducts: [Product] = []
    private(set) var keys: [String] = []
    private(set) var productsGrouped: [String: [Product]] = [:]
    private(set) var stores: [Store] = []
    private var firestoreManager: FirestoreManager
    
    init(firestoreManager: FirestoreManager = FirestoreManager()) {
        self.firestoreManager = firestoreManager
        fetchStores()
    }
    
    private func fetchStores() {
        firestoreManager.fetchStores { result in
            switch result {
            case .success(let stores):
                self.stores = stores
            case .failure(let error):
                print("Error fetching stores: \(error)")
            }
        }
    }
    
    func addFavorite(product: Product) {
        if !favoriteProducts.contains(where: { $0.id == product.id }) {
            favoriteProducts.append(product)
            refreshData()
        }
    }
    
    func removeFavorite(product: Product) {
        favoriteProducts.removeAll { $0.id == product.id }
        refreshData()
    }
    
    func clearFavorites() {
        favoriteProducts.removeAll()
        refreshData()
    }
    
    func refreshData() {
        productsGrouped = groupedFavoriteProducts()
        keys = Array(productsGrouped.keys).sorted()
    }
    
    func groupedFavoriteProducts() -> [String: [Product]] {
        var groupedDict = [String: [Product]]()
        for product in favoriteProducts {
            groupedDict[product.locationId, default: []].append(product)
        }
        return groupedDict
    }
    
    func getLocationName(for locationId: String) -> String {
        switch locationId {
        case "1":
            return "პ.ქავთარაძის 40"
        case "2":
            return "ალ.ყაზბეგის 38"
        case "3":
            return "ს.ეულის 10"
        case "4":
            return "ალ.ყაზბეგის 32"
        default:
            return "Unknown Location"
        }
    }
    
    func getStoreName(for storeId: String) -> String {
        return stores.first(where: { $0.id == storeId })?.name ?? "Unknown Store"
    }
    
    func getStoreImageURL(for storeId: String) -> String {
        return stores.first(where: { $0.id == storeId })?.storeImageURL ?? ""
    }
}
