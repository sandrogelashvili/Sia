//
//  DealsAndOffers.swift
//  Sia
//
//  Created by Sandro Gelashvili on 17.07.24.
//

import Foundation
import FirebaseFirestoreSwift

struct DealsAndOffers: Identifiable, Decodable {
    @DocumentID var id: String?
    let dealId: String
    let dealsImageURL: String
    let title: String
    let storeId: String
    let productIds: [String]
}
