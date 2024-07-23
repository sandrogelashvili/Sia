//
//  SearchResultsView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 22.07.24.
//

import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var viewModel: SearchResultsViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.groupedSearchProducts.keys.sorted(), id: \.self) { location in
                    SearchResultSectionView(location: location, viewModel: viewModel)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct SearchResultSectionView: View {
    let location: String
    @ObservedObject var viewModel: SearchResultsViewModel
    
    var body: some View {
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
            Divider()
        }
    }
}
