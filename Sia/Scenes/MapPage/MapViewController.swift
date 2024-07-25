//
//  MapViewController.swift
//  Sia
//
//  Created by Sandro Gelashvili on 25.07.24.
//

import UIKit
import MapKit
import Combine

final class MapViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    var viewModel = MapViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
        setupUI()
        
        // Fetch locations and update map
        viewModel.fetchLocations()
        viewModel.$locations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] locations in
                self?.updateMapWithLocations(locations)
            }
            .store(in: &cancellables)
    }
    
    private func setupUI() {
        addMapView()
    }
    
    private func addMapView() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func updateMapWithLocations(_ locations: [Location]) {
        mapView.removeAnnotations(mapView.annotations)
        locations.forEach { location in
            guard let latitude = location.latitude, let longitude = location.longitude else {
                print("Invalid coordinates for location: \(location.address)")
                return
            }
            let annotation = MKPointAnnotation()
            annotation.title = location.address
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            mapView.addAnnotation(annotation)
            print("Added annotation for location: \(location.address), coordinates: (\(latitude), \(longitude))")
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Center the map on the user's current location
        guard let location = locations.first else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager,
              let location = locationManager.location else { return }
        
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            let region = MKCoordinateRegion(center: location.coordinate,
                                            latitudinalMeters: 1000,
                                            longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        case .notDetermined, .restricted:
            print("Location cannot be determined or restricted.")
        case .denied:
            print("Location services have been denied.")
        @unknown default:
            print("Unknown error. Unable to get location.")
        }
    }
}
