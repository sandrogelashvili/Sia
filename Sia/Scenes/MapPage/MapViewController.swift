//
//  MapViewController.swift
//  Sia
//
//  Created by Sandro Gelashvili on 25.07.24.
//

import UIKit
import MapKit
import Combine

private enum Constants {
    static let latAndLong: CGFloat = 1000
    
    enum ConstantsStrings {
        static let locationIconName: String = "location.circle.fill"
        static let errorTitle: String = "Error"
        static let actionTitle: String = "OK"
    }
}

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
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = L10n.Map.SearchBar.placeholder
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.barTintColor = .white
        searchBar.backgroundImage = UIImage()
        
        if let textField = searchBar.value(forKey: L10n.Map.SearchBar.forKeyValue) as? UITextField {
            textField.backgroundColor = .white
            textField.layer.cornerRadius = Grid.CornerRadius.textField
            textField.clipsToBounds = true
            
            if let leftView = textField.leftView as? UIImageView {
                leftView.tintColor = .gray
            }
        }
        return searchBar
    }()
    
    lazy var centerLocationButton: UIButton = {
        let button = UIButton(type: .system)
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: Grid.Spacing.xl, weight: .medium, scale: .default)
        let image = UIImage(systemName: Constants.ConstantsStrings.locationIconName, withConfiguration: symbolConfig)
        button.setImage(image, for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestLocation()
        mapView.delegate = self
        setupUI()
        bindViewModel()
        viewModel.fetchStoresAndLocations()
    }
    
    private func setupUI() {
        addMapView()
        addSearchBar()
        addCenterLocationButton()
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
    
    private func addSearchBar() {
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.heightAnchor.constraint(equalToConstant: Grid.Spacing.xl5),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.widthAnchor.constraint(equalToConstant: view.bounds.size.width / 1.1),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: Grid.Spacing.xl4)
        ])
    }
    
    private func addCenterLocationButton() {
        view.addSubview(centerLocationButton)
        centerLocationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerLocationButton.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: Grid.Spacing.l),
            centerLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Grid.Spacing.l),
        ])
        centerLocationButton.addAction(UIAction { [weak self] _ in
            self?.centerMapOnUserLocation()
        }, for: .touchUpInside)
    }
    
    private func centerMapOnUserLocation() {
        guard let location = locationManager?.location else { return }
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: Constants.latAndLong, longitudinalMeters: Constants.latAndLong)
        mapView.setRegion(region, animated: true)
    }
    
    private func bindViewModel() {
        viewModel.$locations
            .receive(on: DispatchQueue.main)
            .sink { [weak self] locations in
                guard let self = self else { return }
                self.viewModel.updateMapWithLocations(locations, mapView: self.mapView)
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let self = self else { return }
                if let message = errorMessage {
                    print(message)
                    self.showErrorMessage(message)
                }
            }
            .store(in: &cancellables)
    }
    
    private func showErrorMessage(_ message: String) {
        let alert = UIAlertController(title: Constants.ConstantsStrings.errorTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ConstantsStrings.actionTitle, style: .default))
        present(alert, animated: true)
    }
    
    func checkLocationAuthorization() {
        viewModel.checkLocationAuthorization(locationManager: locationManager, mapView: mapView)
    }
}
