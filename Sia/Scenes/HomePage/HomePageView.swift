//
//  HomePageView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 08.07.24.
//

import SwiftUI

private enum Constants {
    static let categoryTitleFontSize: CGFloat = 20
    static let filterViewWidthRatio: CGFloat = 0.8
    static let overlayOpacity: Double = 0.4
}

struct HomePageView: View {
    @StateObject private var homePageViewModel = HomePageViewModel()
    @StateObject private var searchResultsViewModel = SearchResultsViewModel()
    @State private var searchText = ""
    @State private var isFilterViewPresented = false
    
    private var gridColumns: [GridItem] {
        [GridItem(.flexible()), GridItem(.flexible())]
    }
    
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
                                searchResultsViewModel.selectedPriceSortOption = homePageViewModel.selectedPriceSortOption
                            }
                        }
                    )
                    
                    if searchText.isEmpty {
                        VStack(alignment: .leading) {
                            Text(L10n.Homepage.selectCategory)
                                .padding(.leading, Grid.Spacing.l)
                                .font(.system(size: Constants.categoryTitleFontSize, weight: .semibold))
                            
                            ScrollView {
                                LazyVGrid(columns: gridColumns, spacing: Grid.Spacing.s) {
                                    ForEach(homePageViewModel.categories) { category in
                                        NavigationLink(destination: CategoryProductsView(category: category, selectedStoreId: homePageViewModel.selectedStoreId, selectedPriceSortOption: homePageViewModel.selectedPriceSortOption)) {
                                            HomePageCategoryCell(categoryName: category.name, imageURL: category.categoryImageURL, color: Color(hex: category.backgroundColor) ?? .gray)
                                        }
                                    }
                                }
                                .padding(.horizontal, Grid.Spacing.s)
                            }
                        }
                    } else {
                        SearchResultsView(viewModel: searchResultsViewModel)
                    }
                }
                .background(Color.gray400SwiftUI)
                
                if isFilterViewPresented {
                    FilterViewOverlay(isFilterViewPresented: $isFilterViewPresented, selectedStoreId: $homePageViewModel.selectedStoreId, selectedPriceSortOption: $homePageViewModel.selectedPriceSortOption)
                }
            }
        }
    }
    
    private struct FilterViewOverlay: View {
        @Binding var isFilterViewPresented: Bool
        @Binding var selectedStoreId: String?
        @Binding var selectedPriceSortOption: PriceSortOption?
        
        var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .trailing) {
                    Color.black.opacity(Constants.overlayOpacity)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isFilterViewPresented = false
                            }
                        }
                    
                    FilterView(isPresented: $isFilterViewPresented, selectedStoreId: $selectedStoreId, selectedPriceSortOption: $selectedPriceSortOption)
                        .frame(width: geometry.size.width * Constants.filterViewWidthRatio, height: geometry.size.height)
                        .background(Color.white)
                        .cornerRadius(Grid.CornerRadius.filter)
                        .shadow(radius: Grid.Spacing.m)
                        .offset(x: isFilterViewPresented ? .zero : geometry.size.width)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
