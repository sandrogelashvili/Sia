//
//  ProductsOnSaleView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 20.07.24.
//

import SwiftUI

struct ProductsOnSaleView: View {
    @StateObject var viewModel: ProductsOnSaleViewModel
    
    var body: some View {
        VStack {
            Text(L10n.ProductsOnSale.title) // ეს შესაცვლელია
                .font(.title)
                .padding()
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(viewModel.saleProducts) { product in
                        ProductCell(
                            productName: product.name,
                            productImageURL: product.productImageURL,
                            stockStatus: product.stockStatus,
                            price: product.price,
                            storeName: viewModel.store.name,
                            storeImageUrl: viewModel.store.storeImageURL,
                            isFavorite: product.isFavorite,
                            onDeal: product.onDeal ?? false,
                            newPrice: product.newPrice,
                            onFavoriteTapped: {
                                viewModel.toggleFavorite(for: product)
                            }
                        )
                    }
                }
            }
            .padding()
        }
    }
}
