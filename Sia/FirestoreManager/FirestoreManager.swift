//
//  FirestoreManager.swift
//  Sia
//
//  Created by Sandro Gelashvili on 10.07.24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class FirestoreManager: ObservableObject {
    @Published var categories: [Category] = []
    
    private var db = Firestore.firestore()
    
    func fetchCategories() {
        db.collection("stores")
            .document("agrohub")
            .collection("locations")
            .document("locationId1")
            .collection("categories")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching categories: \(error)")
                    return
                }
                guard let documents = snapshot?.documents else {
                    print("No documents found")
                    return
                }
                self.categories = documents.compactMap { doc -> Category? in
                    return try? doc.data(as: Category.self)
                }
            }
    }
}
