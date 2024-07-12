//
//  SearchResultsViewControllerWrapper.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import SwiftUI

struct SearchResultsViewControllerWrapper: UIViewControllerRepresentable {
    var products: [Product]
    
    func makeUIViewController(context: Context) -> SearchResultsViewController {
        let viewController = SearchResultsViewController(products: products)
        print("Making UIViewController with products: \(products)")
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: SearchResultsViewController, context: Context) {
        uiViewController.updateProducts(products: products)
        print("Updating UIViewController with products: \(products)")
    }
}
