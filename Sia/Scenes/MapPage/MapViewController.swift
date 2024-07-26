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
    
    lazy var searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.layer.cornerRadius = 10
        searchTextField.clipsToBounds = true
        searchTextField.backgroundColor = UIColor.white
        searchTextField.placeholder = "Search"
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        searchTextField.leftViewMode = .always
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.delegate = self
        return searchTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
        setupUI()
        bindViewModel()
 
        viewModel.fetchStoresAndLocations()
    }

    private func setupUI() {
        addMapView()
        addSearchTextField()
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
    
    private func addSearchTextField() {
        view.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.heightAnchor.constraint(equalToConstant: 44),
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchTextField.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.2),
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
        ])
        searchTextField.returnKeyType = .go
    }
    
    private func bindViewModel() {
        viewModel.$locations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] locations in
                self?.updateMapWithLocations(locations)
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                if let message = errorMessage {
                    self?.showError(message)
                }
            }
            .store(in: &cancellables)
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager,
              let location = locationManager.location else { return }
        
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            let region = MKCoordinateRegion(center: location.coordinate,
                                            latitudinalMeters: 3000,
                                            longitudinalMeters: 3000)
            mapView.setRegion(region, animated: true)
        case .notDetermined, .restricted, .denied:
            showError("Location services are restricted or denied.")
        @unknown default:
            showError("Unknown error. Unable to get location.")
        }
    }
    
    private func findStoresByName(_ name: String) {
        let matchedLocations = viewModel.findLocationsByStoreName(name)
        if let firstLocation = matchedLocations.first {
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: firstLocation.latitude ?? 0.0, longitude: firstLocation.longitude ?? 0.0),
                                            latitudinalMeters: 3000,
                                            longitudinalMeters: 3000)
            mapView.setRegion(region, animated: true)
        }
        showLocationsOnMap(locations: matchedLocations)
    }
    
    private func showLocationsOnMap(locations: [Location]) {
        mapView.removeAnnotations(mapView.annotations)
        locations.forEach { location in
            let annotation = MKPointAnnotation()
            annotation.title = location.address
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude ?? 0.0, longitude: location.longitude ?? 0.0)
            mapView.addAnnotation(annotation)
        }
    }
    
    private func updateMapWithLocations(_ locations: [Location]) {
        mapView.removeAnnotations(mapView.annotations)
        locations.forEach { location in
            let annotation = MKPointAnnotation()
            annotation.title = location.address
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude ?? 0.0, longitude: location.longitude ?? 0.0)
            mapView.addAnnotation(annotation)
        }
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension MapViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text ?? ""
        if !text.isEmpty {
            textField.resignFirstResponder()
            findStoresByName(text)
        }
        return true
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Do nothing
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showError("Failed to get location: \(error.localizedDescription)")
    }
}
