//
//  Location.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import Foundation
import FirebaseFirestoreSwift

struct Location: Identifiable, Decodable {
    @DocumentID var id: String?
    let locationId: String
    let address: String
    let openingHours: String
    let storeId: String
}
