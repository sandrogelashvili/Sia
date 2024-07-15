//
//  TabBarView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import SwiftUI

struct TabBarView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBar.appearance().isTranslucent = true
    }
    
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Image("Home")
                    Text("მთავარი")
                }
            
            ListPageViewControllerWrapper()
                 .tabItem {
                     Image("List")
                     Text("პროდუქტების სია")
                 }
            
            StorePageViewControllerWrapper()
                .tabItem {
                    Image("Store")
                    Text("მაღაზიები")
                }
        }
        .accentColor(Color("AppThemeGreen"))
    }
}

#Preview {
    TabBarView()
}
