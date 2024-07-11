//
//  Store.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import Foundation
import FirebaseFirestoreSwift

struct Store: Identifiable, Decodable {
    @DocumentID var id: String?
    var name: String
    var storeImageURL: String
}
