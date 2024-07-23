//
//  HomePageView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 08.07.24.
//

import SwiftUI

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
                            Text("აირჩიეთ კატეგორია")
                                .padding(.leading, 20)
                                .font(.system(size: 20, weight: .semibold))
                            
                            ScrollView {
                                LazyVGrid(columns: [GridItem(.flexible()),
                                                    GridItem(.flexible())],
                                          spacing: 10) {
                                    ForEach(homePageViewModel.categories) { category in
                                        NavigationLink(destination: CategoryProductsView(category: category,
                                                                                         selectedStoreId: homePageViewModel.selectedStoreId)) {
                                            HomePageCategoryCell(categoryName: category.name,
                                                                 imageURL: category.categoryImageURL,
                                                                 color: Color(hex: category.backgroundColor) ?? .gray)
                                        }
                                    }
                                }
                                          .padding(.horizontal)
                            }
                        }
                    } else {
                        SearchResultsView(viewModel: searchResultsViewModel)
                    }
                }
                .background(Color("BackgroundColor"))
                
                if isFilterViewPresented {
                    FilterViewOverlay(isFilterViewPresented: $isFilterViewPresented,
                                      selectedStoreId: $homePageViewModel.selectedStoreId)
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
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isFilterViewPresented = false
                            }
                        }
                    
                    FilterView(isPresented: $isFilterViewPresented, selectedStoreId: $selectedStoreId)
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(radius: 5)
                        .offset(x: isFilterViewPresented ? 0 : geometry.size.width)
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

