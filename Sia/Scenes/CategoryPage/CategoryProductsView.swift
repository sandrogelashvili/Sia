//
//  CategoryProductsView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 13.07.24.
//

import SwiftUI

struct CategoryProductsView: View {
    @StateObject private var viewModel: CategoryProductsViewModel
    private var gridColumns: [GridItem] { [GridItem(.fixed(165),
                                                    spacing: 20),
                                           GridItem(.fixed(165),
                                                    spacing: 20)] }
    
    init(category: Category,
         selectedStoreId: String?) {
        _viewModel = StateObject(wrappedValue: CategoryProductsViewModel(category: category,
                                                                         selectedStoreId: selectedStoreId))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.groupedProducts.keys.sorted(), id: \.self) { location in
                    Section(header: sectionHeader(for: location)) {
                        LazyVGrid(columns: gridColumns, spacing: 5) {
                            ForEach(viewModel.groupedProducts[location] ?? []) { product in
                                ProductCell(
                                    productName: product.name,
                                    productImageURL: product.productImageURL,
                                    stockStatus: product.stockStatus,
                                    price: product.price,
                                    storeName: viewModel.getStoreName(for: product.storeId),
                                    storeImageUrl: viewModel.getStoreImageURL(for: product.storeId),
                                    isFavorite: product.isFavorite,
                                    onDeal: product.onDeal ?? false,
                                    newPrice: product.newPrice,
                                    onFavoriteTapped: {
                                        viewModel.toggleFavorite(for: product)
                                    }
                                )
                            }
                        }
                        .padding(.bottom)
                        
                        Divider()
                    }
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.category.name)
        .background(Color("BackgroundColor"))
    }
    
    private func sectionHeader(for location: String) -> some View {
        Text(location)
            .font(.system(size: 25, weight: .bold))
            .padding(.vertical)
    }
}
