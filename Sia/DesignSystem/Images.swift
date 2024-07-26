//
//  Images.swift
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
    static let iconTabBarMap = Image(systemName: "location")
    
    // MARK: - SearchAndFilterIcons
    static let iconSearch = Image(systemName: "magnifyingglass")
    static let iconFilter = Image(systemName: "slider.horizontal.3")
    
    // MARK: - ProductCellIcons
    static let iconProductCellMinus = Image(systemName: "minus.square")
    static let iconProductCellHeart = Image(systemName: "heart")
    
    
    // MARK: - FilterView
    static let iconForCancelButton = Image(systemName: "x.circle.fill")
    
    // MARK: - OnboardingView
    static let imageForFirsObPage = Image("Onboarding21")
    static let imageForSecondObPage = Image("onBoarding22")
    static let imageForThirdPage = Image("Onboarding20")
}
