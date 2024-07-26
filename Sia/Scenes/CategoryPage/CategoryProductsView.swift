//
//  CategoryProductsView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 13.07.24.
//

import SwiftUI

private enum Constants {
    static let gridItemFixedSize: CGFloat = 166
    static let sectionHeaderFontSize: CGFloat = 24
}

struct CategoryProductsView: View {
    @StateObject private var viewModel: CategoryProductsViewModel
    private var gridColumns: [GridItem] {
        [GridItem(.fixed(Constants.gridItemFixedSize),
                  spacing: Grid.Spacing.l),
         GridItem(.fixed(Constants.gridItemFixedSize),
                  spacing: Grid.Spacing.l)]
    }
    
    init(category: Category, selectedStoreId: String?, selectedPriceSortOption: PriceSortOption?) {
        _viewModel = StateObject(wrappedValue: CategoryProductsViewModel(category: category,
                                                                         selectedStoreId: selectedStoreId,
                                                                         selectedPriceSortOption: selectedPriceSortOption))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.groupedProducts.keys.sorted(), id: \.self) { location in
                    Section(header: sectionHeader(for: location)) {
                        LazyVGrid(columns: gridColumns,
                                  spacing: Grid.Spacing.xs2) {
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
                                  .padding(.bottom, Grid.Spacing.s)
                        
                        Divider()
                    }
                }
            }
            .padding(Grid.Spacing.s)
        }
        .navigationTitle(viewModel.category.name)
        .background(Color.gray400SwiftUI)
    }
    
    private func sectionHeader(for location: String) -> some View {
        Text(location)
            .font(.system(size: Constants.sectionHeaderFontSize, weight: .bold))
            .padding(.vertical, Grid.Spacing.s)
    }
}
