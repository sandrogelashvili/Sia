//
//  Category.swift
//  Sia
//
//  Created by Sandro Gelashvili on 10.07.24.
//

import Foundation
import FirebaseFirestoreSwift

struct Category: Identifiable, Decodable {
    @DocumentID var id: String?
    let categoryId: String
    let name: String
    let categoryImageURL: String
    let backgroundColor: String
}
