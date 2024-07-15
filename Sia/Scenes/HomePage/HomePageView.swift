//
//  HomePageView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 08.07.24.
//

import SwiftUI

struct HomePageView: View {
    @StateObject private var viewModel = HomePageViewModel()
    @State private var searchText = ""
    @State private var isFilterViewPresented = false
    @State private var selectedCategory: Category? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    SearchBarFilterRC(searchText: $searchText,
                                      filterAction: {
                        withAnimation {
                            isFilterViewPresented = true
                        }
                    }, searchAction: {
                        withAnimation {
                            viewModel.search(query: searchText)
                        }
                    })
                    
                    if searchText.isEmpty {
                        homePageContent
                    } else {
                        searchResultsView
                    }
                }
                .background(Color("BackgroundColor"))
                
                if isFilterViewPresented {
                    GeometryReader { geometry in
                        ZStack(alignment: .trailing) {
                            Color.black.opacity(0.4)
                                .edgesIgnoringSafeArea(.all)
                                .onTapGesture {
                                    withAnimation {
                                        isFilterViewPresented = false
                                    }
                                }
                            
                            FilterView(isPresented: $isFilterViewPresented, selectedStoreId: $viewModel.selectedStoreId)
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
            .navigationDestination(isPresented: Binding(
                get: { selectedCategory != nil },
                set: { if !$0 { selectedCategory = nil } }
            )) {
                if let selectedCategory = selectedCategory {
                    CategoryProductsView(category: selectedCategory,
                                         selectedStoreId: viewModel.selectedStoreId)
                }
            }
        }
    }
    
    private var homePageContent: some View {
        VStack(alignment: .leading) {
            Text("აირჩიეთ კატეგორია")
                .padding(.leading, 20)
                .font(.system(size: 20, weight: .semibold))
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(viewModel.categories) { category in
                        Button(action: {
                            selectedCategory = category
                        }) {
                            CategoryCellView(categoryName: category.name,
                                             imageURL: category.categoryImageURL,
                                             color: Color(hex: category.backgroundColor) ?? .gray)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private var searchResultsView: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.groupedSearchProducts.keys.sorted(), id: \.self) { location in
                    Section(header: Text(location).font(.headline).padding()) {
                        LazyVGrid(columns: [
                            GridItem(.fixed(165), spacing: 20),
                            GridItem(.fixed(165), spacing: 20)
                        ], spacing: 5) {
                            ForEach(viewModel.groupedSearchProducts[location] ?? []) { product in
                                ProductCell(
                                    productName: product.name,
                                    productImageURL: product.productImageURL,
                                    stockStatus: product.stockStatus,
                                    price: product.price,
                                    storeName: viewModel.getStoreName(for: product.storeId),
                                    storeImageUrl: viewModel.getStoreImageURL(for: product.storeId)
                                )
                            }
                        }
                        Divider()
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    HomePageView()
}
