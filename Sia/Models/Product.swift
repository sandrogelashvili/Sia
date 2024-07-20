//
//  Product.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import Foundation
import FirebaseFirestoreSwift

struct Product: Identifiable, Decodable {
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
}
