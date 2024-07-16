//
//  FavoritesManager.swift
//  Sia
//
//  Created by Sandro Gelashvili on 15.07.24.
//

import Foundation

class FavoritesManager {
    static let shared = FavoritesManager()
    
    private init() {}
    
    func toggleFavorite(product: inout Product, allProducts: inout [Product]) {
        if let index = allProducts.firstIndex(where: { $0.id == product.id }) {
            allProducts[index].isFavorite.toggle()
            if allProducts[index].isFavorite {
                ListPageViewModel.shared.addFavorite(product: allProducts[index])
            } else {
                ListPageViewModel.shared.removeFavorite(product: allProducts[index])
            }
        }
    }
}
