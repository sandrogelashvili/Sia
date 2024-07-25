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
                    Image .iconTabBarHome
                    Text(L10n.Tabbar.home)
                }
            
            ListPageViewControllerWrapper()
                .tabItem {
                    Image .iconTabBarList
                    Text(L10n.Tabbar.list)
                }
            
            StorePageViewControllerWrapper()
                .tabItem {
                    Image .iconTabBarStore
                    Text(L10n.Tabbar.store)
                }
            
            MapViewControllerWrapper()
                .tabItem {
                    Image(systemName: "location")
                    Text("რუკა")
                }
        }
        .accentColor(Color.appThemeGreenSwiftUI)
    }
}

#Preview {
    TabBarView()
}
