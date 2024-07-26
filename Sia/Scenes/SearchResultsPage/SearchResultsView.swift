//
//  SearchResultsView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 22.07.24.
//

import SwiftUI

private enum Constants {
    static let sectionHeaderFontSize: CGFloat = 18
    static let gridItemFixedSize: CGFloat = 165
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
            .padding(.horizontal, Grid.Spacing.s)
        }
    }
}

struct SearchResultSectionView: View {
    let location: String
    @ObservedObject var viewModel: SearchResultsViewModel
    
    private var gridColumns: [GridItem] {
        [GridItem(.fixed(Constants.gridItemFixedSize), spacing: Grid.Spacing.l),
         GridItem(.fixed(Constants.gridItemFixedSize), spacing: Grid.Spacing.l)]
    }
    
    var body: some View {
        Section(header: sectionHeader) {
            LazyVGrid(columns: gridColumns,
                      spacing: Grid.Spacing.xs) {
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
    
    private var sectionHeader: some View {
        Text(location)
            .font(.system(size: Constants.sectionHeaderFontSize))
            .padding(Grid.Spacing.s)
    }
}
