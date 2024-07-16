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
    @Published var locations: [Location] = []
    
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
    
    func fetchStores(completion: @escaping (Result<[Store], Error>) -> Void) {
        db.collection("stores").getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            let stores = documents.compactMap { doc -> Store? in
                return try? doc.data(as: Store.self)
            }
            self.stores = stores
            completion(.success(stores))
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
    
    func fetchLocations() -> Future<[Location], Error> {
        return Future { promise in
            self.db.collection("stores").getDocuments { (snapshot, error) in
                if let error = error {
                    promise(.failure(error))
                    return
                }
                guard let documents = snapshot?.documents else {
                    promise(.success([]))
                    return
                }
                
                var allLocations: [Location] = []
                let dispatchGroup = DispatchGroup()
                
                for document in documents {
                    dispatchGroup.enter()
                    document.reference.collection("locations").getDocuments { (locationSnapshot, locationError) in
                        if let locationError = locationError {
                            print("Error fetching locations: \(locationError)")
                        } else {
                            let locations = locationSnapshot?.documents.compactMap { doc -> Location? in
                                return try? doc.data(as: Location.self)
                            } ?? []
                            allLocations.append(contentsOf: locations)
                        }
                        dispatchGroup.leave()
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    promise(.success(allLocations))
                }
            }
        }
    }
    
    func fetchLocationsForListPage(completion: @escaping (Result<[Location], Error>) -> Void) {
        db.collection("stores").getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            
            var allLocations: [Location] = []
            let dispatchGroup = DispatchGroup()
            
            for document in documents {
                dispatchGroup.enter()
                document.reference.collection("locations").getDocuments { (locationSnapshot, locationError) in
                    if let locationError = locationError {
                        print("Error fetching locations: \(locationError)")
                    } else {
                        let locations = locationSnapshot?.documents.compactMap { doc -> Location? in
                            return try? doc.data(as: Location.self)
                        } ?? []
                        allLocations.append(contentsOf: locations)
                    }
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(.success(allLocations))
            }
        }
    }
}
