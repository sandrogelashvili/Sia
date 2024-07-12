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
    @Published var stores: [Store] = []
    @Published var allProducts: [Product] = []
    
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
    
    func fetchStores() {
        db.collection("stores")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching stores: \(error)")
                    return
                }
                guard let documents = snapshot?.documents else {
                    print("No documents found")
                    return
                }
                self.stores = documents.compactMap { doc -> Store? in
                    return try? doc.data(as: Store.self)
                }
            }
    }
    
    func fetchAllProducts() -> Future<[Product], Error> {
        return Future { promise in
            self.db.collectionGroup("products").getDocuments { (snapshot, error) in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                guard let documents = snapshot?.documents else {
                    promise(.success([]))
                    return
                }
                let products = documents.compactMap { doc -> Product? in
                    do {
                        var product = try doc.data(as: Product.self)
                        product.documentID = doc.documentID
                        return product
                    } catch {
                        print("Error decoding product: \(error)")
                        return nil
                    }
                }
                promise(.success(products))
            }
        }
    }
}
