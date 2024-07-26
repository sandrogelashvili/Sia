//
//  MapViewControllerWrapper.swift
//  Sia
//
//  Created by Sandro Gelashvili on 25.07.24.
//

import SwiftUI

struct MapViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> MapViewController {
        return MapViewController()
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        
    }
}
