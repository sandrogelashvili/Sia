//
//  HomePageView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 08.07.24.
//

import SwiftUI

private enum HomePageConstants {
    static let leadingPadding: CGFloat = 20
    static let categoryTitleFontSize: CGFloat = 20
    static let categoryTitleFontWeight: Font.Weight = .semibold
    static let gridSpacing: CGFloat = 10
    static let horizontalPadding: CGFloat = 10
    static let filterViewWidthRatio: CGFloat = 0.8
    static let filterViewCornerRadius: CGFloat = 16
    static let filterViewShadowRadius: CGFloat = 5
    static let overlayOpacity: Double = 0.4
}

struct HomePageView: View {
    @StateObject private var homePageViewModel = HomePageViewModel()
    @StateObject private var searchResultsViewModel = SearchResultsViewModel()
    @State private var searchText = ""
    @State private var isFilterViewPresented = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    SearchBarFilterView(
                        searchText: $searchText,
                        filterAction: {
                            withAnimation {
                                isFilterViewPresented = true
                            }
                        },
                        searchAction: {
                            withAnimation {
                                searchResultsViewModel.search(query: searchText)
                                searchResultsViewModel.selectedStoreId = homePageViewModel.selectedStoreId
                            }
                        }
                    )
                    
                    if searchText.isEmpty {
                        VStack(alignment: .leading) {
                            Text(L10n.Homepage.selectCategory)
                                .padding(.leading, HomePageConstants.leadingPadding)
                                .font(.system(size: HomePageConstants.categoryTitleFontSize, weight: HomePageConstants.categoryTitleFontWeight))
                            
                            ScrollView {
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: HomePageConstants.gridSpacing) {
                                    ForEach(homePageViewModel.categories) { category in
                                        NavigationLink(destination: CategoryProductsView(category: category, selectedStoreId: homePageViewModel.selectedStoreId)) {
                                            HomePageCategoryCell(categoryName: category.name, imageURL: category.categoryImageURL, color: Color(hex: category.backgroundColor) ?? .gray)
                                        }
                                    }
                                }
                                .padding(.horizontal, HomePageConstants.horizontalPadding)
                            }
                        }
                    } else {
                        SearchResultsView(viewModel: searchResultsViewModel)
                    }
                }
                .background(Color.gray400SwiftUI)
                
                if isFilterViewPresented {
                    FilterViewOverlay(isFilterViewPresented: $isFilterViewPresented, selectedStoreId: $homePageViewModel.selectedStoreId)
                }
            }
        }
    }
    
    private struct FilterViewOverlay: View {
        @Binding var isFilterViewPresented: Bool
        @Binding var selectedStoreId: String?
        
        var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .trailing) {
                    Color.black.opacity(HomePageConstants.overlayOpacity)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isFilterViewPresented = false
                            }
                        }
                    
                    FilterView(isPresented: $isFilterViewPresented, selectedStoreId: $selectedStoreId)
                        .frame(width: geometry.size.width * HomePageConstants.filterViewWidthRatio, height: geometry.size.height)
                        .background(Color.white)
                        .cornerRadius(HomePageConstants.filterViewCornerRadius)
                        .shadow(radius: HomePageConstants.filterViewShadowRadius)
                        .offset(x: isFilterViewPresented ? .zero : geometry.size.width)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
