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
        }
        .accentColor(Color("AppThemeGreen"))
    }
}

#Preview {
    TabBarView()
}
