//
//  ListPageViewModel.swift
//  Sia
//
//  Created by Sandro Gelashvili on 15.07.24.
//

import Foundation

private enum ListPageViewModelConstants {
    static let location1 = "1"
    static let location2 = "2"
    static let location3 = "3"
    static let location4 = "4"
}

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
        case ListPageViewModelConstants.location1:
            return L10n.Listpage.location1
        case ListPageViewModelConstants.location2:
            return L10n.Listpage.location2
        case ListPageViewModelConstants.location3:
            return L10n.Listpage.location3
        case ListPageViewModelConstants.location4:
            return L10n.Listpage.location4
        default:
            return L10n.Listpage.unknownLocation
        }
    }
    
    func getStoreName(for storeId: String) -> String {
        return stores.first(where: { $0.id == storeId })?.name ?? L10n.Listpage.unknownStore
    }
    
    func getStoreImageURL(for storeId: String) -> String {
        return stores.first(where: { $0.id == storeId })?.storeImageURL ?? ""
    }
}
