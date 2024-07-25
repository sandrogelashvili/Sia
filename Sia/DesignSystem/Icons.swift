//
//  Icons.swift
//  Sia
//
//  Created by Sandro Gelashvili on 24.07.24.
//

import UIKit
import SwiftUI

extension Image {
    // MARK: - AsyncImage
    static let loaderPhoto = Image(systemName: "photo")
    
    // MARK: - TabBarIcons
    static let iconTabBarHome = Image(systemName: "house")
    static let iconTabBarList = Image(systemName: "list.clipboard")
    static let iconTabBarStore = Image(systemName: "storefront")
    
    // MARK: - SearchAndFilterIcons
    static let iconSearch = Image(systemName: "magnifyingglass")
    static let iconFilter = Image(systemName: "slider.horizontal.3")
    
    // MARK: - ProductCellIcons
    static let iconProductCellMinus = Image(systemName: "minus.square")
    static let iconProductCellHeart = Image(systemName: "heart")
    
    
    // MARK: - FilterView
    static let iconForCancelButton = Image(systemName: "x.circle.fill")
}
