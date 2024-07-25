//
//  SearchResultsView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 22.07.24.
//

import SwiftUI

private enum SearchResultsConstants {
    static let horizontalPadding: CGFloat = 10
    static let sectionHeaderPadding: CGFloat = 10
    static let gridItemFixedSize: CGFloat = 165
    static let gridItemSpacing: CGFloat = 20
    static let gridSpacing: CGFloat = 5
}

struct SearchResultsView: View {
    @ObservedObject var viewModel: SearchResultsViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.groupedSearchProducts.keys.sorted(), id: \.self) { location in
                    SearchResultSectionView(location: location, viewModel: viewModel)
                }
            }
            .padding(.horizontal, SearchResultsConstants.horizontalPadding)
        }
    }
}

struct SearchResultSectionView: View {
    let location: String
    @ObservedObject var viewModel: SearchResultsViewModel
    
    var body: some View {
        Section(header: Text(location).font(.headline).padding(SearchResultsConstants.sectionHeaderPadding)) {
            LazyVGrid(columns: [
                GridItem(.fixed(SearchResultsConstants.gridItemFixedSize), spacing: SearchResultsConstants.gridItemSpacing),
                GridItem(.fixed(SearchResultsConstants.gridItemFixedSize), spacing: SearchResultsConstants.gridItemSpacing)
            ], spacing: SearchResultsConstants.gridSpacing) {
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
