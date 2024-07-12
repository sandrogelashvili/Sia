//
//  ListPageViewControllerWrapper.swift
//  Sia
//
//  Created by Sandro Gelashvili on 12.07.24.
//

import SwiftUI

struct ListPageViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ListPageViewController {
        return ListPageViewController()
    }

    func updateUIViewController(_ uiViewController: ListPageViewController, context: Context) {}
}
