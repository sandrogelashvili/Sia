//
//  StorePageViewControllerWrapper.swift
//  Sia
//
//  Created by Sandro Gelashvili on 15.07.24.
//

import SwiftUI

struct StorePageViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> StoresPageViewController {
        return StoresPageViewController()
    }

    func updateUIViewController(_ uiViewController: StoresPageViewController, context: Context) {}
}
