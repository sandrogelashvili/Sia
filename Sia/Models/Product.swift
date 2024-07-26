//
//  Product.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import Foundation
import FirebaseFirestoreSwift

struct Product: Identifiable, Codable {
    @DocumentID var documentID: String?
    let id: String
    let name: String
    let price: Double
    let productImageURL: String
    let stockStatus: String
    let weight: Int
    let categoryId: String
    let locationId: String
    let storeId: String
    var isFavorite: Bool
    let onDeal: Bool?
    let newPrice: Double?
    
    enum CodingKeys: String, CodingKey {
        case documentID
        case id
        case name
        case price
        case productImageURL
        case stockStatus
        case weight
        case categoryId
        case locationId
        case storeId
        case isFavorite
        case onDeal
        case newPrice
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        documentID = try container.decodeIfPresent(String.self, forKey: .documentID)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(Double.self, forKey: .price)
        productImageURL = try container.decode(String.self, forKey: .productImageURL)
        stockStatus = try container.decode(String.self, forKey: .stockStatus)
        weight = try container.decode(Int.self, forKey: .weight)
        categoryId = try container.decode(String.self, forKey: .categoryId)
        locationId = try container.decode(String.self, forKey: .locationId)
        storeId = try container.decode(String.self, forKey: .storeId)
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
        onDeal = try container.decodeIfPresent(Bool.self, forKey: .onDeal)
        newPrice = try container.decodeIfPresent(Double.self, forKey: .newPrice)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(documentID, forKey: .documentID)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(productImageURL, forKey: .productImageURL)
        try container.encode(stockStatus, forKey: .stockStatus)
        try container.encode(weight, forKey: .weight)
        try container.encode(categoryId, forKey: .categoryId)
        try container.encode(locationId, forKey: .locationId)
        try container.encode(storeId, forKey: .storeId)
        try container.encode(isFavorite, forKey: .isFavorite)
        try container.encode(onDeal, forKey: .onDeal)
        try container.encode(newPrice, forKey: .newPrice)
    }
}
