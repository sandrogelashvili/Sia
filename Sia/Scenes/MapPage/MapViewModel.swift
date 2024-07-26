//
//  MapViewModel.swift
//  Sia
//
//  Created by Sandro Gelashvili on 25.07.24.
//

import Combine
import FirebaseFirestore
import MapKit

private enum Constants {
    static let checkLocationLatAndLong: CGFloat = 1000
    static let centerMapLatAndLong: CGFloat = 2000
    
    enum ConstantsStrings {
        static let locationDenied: String = "Location services are restricted or denied."
        static let unknownError: String = "Unknown error. Unable to get location."
    }
}

final class MapViewModel: ObservableObject {
    @Published var locations: [Location] = []
    @Published var stores: [Store] = []
    @Published var errorMessage: String? = nil
    private var firestoreManager = FirestoreManager()
    private var cancellables = Set<AnyCancellable>()
    
    func fetchStoresAndLocations() {
        let storesPublisher = Future<[Store], Error> { promise in
            self.firestoreManager.fetchStores { result in
                switch result {
                case .success(let stores):
                    promise(.success(stores))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        
        let locationsPublisher = firestoreManager.fetchLocations()
        
        Publishers.Zip(storesPublisher, locationsPublisher)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    self.errorMessage = "Error fetching data: \(error.localizedDescription)"
                }
            }, receiveValue: { [weak self] stores, locations in
                self?.stores = stores
                self?.locations = locations
            })
            .store(in: &cancellables)
    }
    
    func findLocationsByStoreName(_ name: String, mapView: MKMapView?) {
        let matchedStores = stores.filter { $0.name.localizedCaseInsensitiveContains(name) }
        let matchedStoreIds = matchedStores.compactMap { $0.id }
        let matchedLocations = locations.filter { matchedStoreIds.contains($0.storeId) }
        updateMapWithLocations(matchedLocations, mapView: mapView)
        if let firstLocation = matchedLocations.first {
            centerMapOnLocation(latitude: firstLocation.latitude, longitude: firstLocation.longitude, mapView: mapView)
        }
    }
    
    func checkLocationAuthorization(locationManager: CLLocationManager?, mapView: MKMapView?) {
        guard let locationManager = locationManager,
              let location = locationManager.location else { return }
        
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            let region = MKCoordinateRegion(center: location.coordinate,
                                            latitudinalMeters: Constants.checkLocationLatAndLong,
                                            longitudinalMeters: Constants.checkLocationLatAndLong)
            mapView?.setRegion(region, animated: true)
        case .notDetermined, .restricted, .denied:
            print(Constants.ConstantsStrings.locationDenied)
        @unknown default:
            print(Constants.ConstantsStrings.unknownError)
        }
    }
    
    func updateMapWithLocations(_ locations: [Location], mapView: MKMapView?) {
        mapView?.removeAnnotations(mapView?.annotations ?? [])
        locations.forEach { location in
            let annotation = MKPointAnnotation()
            annotation.title = location.address
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude ?? 0.0, longitude: location.longitude ?? 0.0)
            mapView?.addAnnotation(annotation)
        }
    }
    
    func centerMapOnLocation(latitude: Double?, longitude: Double?, mapView: MKMapView?) {
        guard let latitude = latitude, let longitude = longitude else { return }
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude,
                                                                       longitude: longitude),
                                        latitudinalMeters: Constants.centerMapLatAndLong,
                                        longitudinalMeters: Constants.centerMapLatAndLong)
        mapView?.setRegion(region, animated: true)
    }
}
