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
}
