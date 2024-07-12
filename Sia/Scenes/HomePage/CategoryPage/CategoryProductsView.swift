//
//  CategoryProductsView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 13.07.24.
//

import SwiftUI

struct CategoryProductsView: View {
    @StateObject private var viewModel: CategoryProductsViewModel
    
    init(category: Category, selectedStoreId: String?) {
        _viewModel = StateObject(wrappedValue: CategoryProductsViewModel(category: category, selectedStoreId: selectedStoreId))
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.fixed(165), spacing: 20),
                GridItem(.fixed(165), spacing: 20)
            ], spacing: 5) {
                ForEach(viewModel.products, id: \.id) { product in
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
            .padding()
        }
        .navigationTitle(viewModel.category.name)
        .background(Color("BackgroundColor"))
    }
}

