//
//  CategoryProductsView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 13.07.24.
//

import SwiftUI

private enum CategoryProductsConstants {
    static let gridItemFixedSize: CGFloat = 165
    static let gridItemSpacing: CGFloat = 20
    static let gridSpacing: CGFloat = 5
    static let sectionHeaderFontSize: CGFloat = 25
    static let sectionHeaderPaddingVertical: CGFloat = 10
    static let sectionPaddingBottom: CGFloat = 10
    static let viewPadding: CGFloat = 10
}

struct CategoryProductsView: View {
    @StateObject private var viewModel: CategoryProductsViewModel
    private var gridColumns: [GridItem] {
        [GridItem(.fixed(CategoryProductsConstants.gridItemFixedSize),
                  spacing: CategoryProductsConstants.gridItemSpacing),
         GridItem(.fixed(CategoryProductsConstants.gridItemFixedSize),
                  spacing: CategoryProductsConstants.gridItemSpacing)]
    }
    
    init(category: Category, selectedStoreId: String?) {
        _viewModel = StateObject(wrappedValue: CategoryProductsViewModel(category: category,
                                                                         selectedStoreId: selectedStoreId))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.groupedProducts.keys.sorted(), id: \.self) { location in
                    Section(header: sectionHeader(for: location)) {
                        LazyVGrid(columns: gridColumns, spacing: CategoryProductsConstants.gridSpacing) {
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
                        .padding(.bottom, CategoryProductsConstants.sectionPaddingBottom)
                        
                        Divider()
                    }
                }
            }
            .padding(CategoryProductsConstants.viewPadding)
        }
        .navigationTitle(viewModel.category.name)
        .background(Color.gray400SwiftUI)
    }
    
    private func sectionHeader(for location: String) -> some View {
        Text(location)
            .font(.system(size: CategoryProductsConstants.sectionHeaderFontSize, weight: .bold))
            .padding(.vertical, CategoryProductsConstants.sectionHeaderPaddingVertical)
    }
}
