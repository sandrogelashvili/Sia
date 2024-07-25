//
//  PlaceAnnotation.swift
//  Sia
//
//  Created by Sandro Gelashvili on 26.07.24.
//

import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(mapItem: MKMapItem) {
        self.coordinate = mapItem.placemark.coordinate
        self.title = mapItem.name
        self.subtitle = mapItem.placemark.title
    }
    
    init(location: Location) {
        self.coordinate = CLLocationCoordinate2D(latitude: location.latitude ?? 0.0, longitude: location.longitude ?? 0.0)
        self.title = location.address
    }
}
