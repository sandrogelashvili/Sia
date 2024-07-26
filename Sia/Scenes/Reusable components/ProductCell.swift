//
//  ProductCollectionViewCell.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import SwiftUI

private enum Constants {
    static let strokeOpacity: Double = 0.5
    static let shadowRadius: CGFloat = 1
    static let productNameFontSize: CGFloat = 14
    static let stockStatusFontSize: CGFloat = 10
    static let stockStatusWidth: CGFloat = 60
    static let storeNameFontSize: CGFloat = 12
    static let priceFontSize: CGFloat = 14
    static let cellWidth: CGFloat = 170
    static let cellHeight: CGFloat = 230
    static let productImageHeight: CGFloat = 110
}

struct ProductCell: View {
    let productName: String
    let productImageURL: String
    let stockStatus: String
    let price: Double
    let storeName: String
    let storeImageUrl: String
    let isFavorite: Bool
    let onDeal: Bool
    let newPrice: Double?
    let onFavoriteTapped: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Grid.CornerRadius.textField)
                .stroke(Color.gray.opacity(Constants.strokeOpacity), lineWidth: Grid.BorderWidth.thin)
            
            VStack {
                productNameLabel
                    .padding(.top, Grid.Spacing.s)
                
                ZStack {
                    productImageView
                    
                    HStack {
                        Spacer()
                        
                        stockStatusLabel
                            .offset(y: -Grid.Spacing.m)
                    }
                }
                Spacer()
                
                VStack(alignment: .leading) {
                    HStack {
                        storeImageForCell
                        
                        storeNameForCell
                            .offset(y: Grid.Spacing.s)
                    }
                    .padding(.leading, -Grid.Spacing.xs)
                    
                    HStack(alignment: .bottom) {
                        VStack {
                            
                            if onDeal, let newPrice = newPrice {
                                priceWithDealLabel(originalPrice: price, newPrice: newPrice)
                                    .padding(.top, Grid.Spacing.s)
                            } else {
                                priceLabel
                                    .padding(.top, Grid.Spacing.s)
                            }
                        }
                        Spacer()
                        favoriteButton
                            .padding(.trailing, Grid.Spacing.s)
                    }
                    .padding(.leading, Grid.Spacing.s)
                    .padding(.bottom, Grid.Spacing.s)
                }
            }
        }
        .background(Color.white)
        .frame(width: Constants.cellWidth, height: Constants.cellHeight)
        .cornerRadius(Grid.CornerRadius.textField)
        .shadow(radius: Constants.shadowRadius)
        .padding(Grid.Spacing.xs2)
    }
    
    private var productNameLabel: some View {
        Text(productName)
            .foregroundColor(.black)
            .font(.system(size: Constants.productNameFontSize, weight: .semibold))
            .multilineTextAlignment(.center)
    }
    
    private var productImageView: some View {
        AsyncImageView(imageURL: productImageURL, height: Constants.productImageHeight)
    }
    
    private var stockStatusLabel: some View {
        Text(stockStatus)
            .foregroundColor(stockStatusColor)
            .font(.system(size: Constants.stockStatusFontSize, weight: .semibold))
            .frame(width: Constants.stockStatusWidth, height: Grid.Spacing.l)
            .background(Color.gray.opacity(Grid.BorderWidth.extraThin))
            .cornerRadius(Grid.CornerRadius.textField)
    }
    
    private var storeImageForCell: some View {
        AsyncImageView(imageURL: storeImageUrl, height: Grid.Spacing.l)
    }
    
    private var storeNameForCell: some View {
        Text(storeName)
            .foregroundColor(.gray)
            .font(.system(size: Constants.storeNameFontSize))
    }
    
    private var priceLabel: some View {
        Text(formattedPrice(price))
            .foregroundColor(.black)
            .font(.system(size: Constants.priceFontSize, weight: .medium))
    }
    
    private var favoriteButton: some View {
        Button(action: {
            onFavoriteTapped()
        }) {
            if isFavorite {
                Image .iconProductCellMinus
                    .resizable()
                    .frame(width: Grid.Spacing.xl3, height: Grid.Spacing.xl3)
                    .foregroundColor(Color.appThemeGreenSwiftUI)
                    .background(Color.white)
                    .cornerRadius(Grid.CornerRadius.textField)
            } else {
                Image .iconProductCellHeart
                    .foregroundColor(.white)
                    .frame(width: Grid.Spacing.xl3, height: Grid.Spacing.xl3)
                    .background(Color.appThemeGreenSwiftUI)
                    .cornerRadius(Grid.CornerRadius.textField)
            }
        }
    }
    
    private var stockStatusColor: Color {
        switch stockStatus {
        case L10n.ProductCell.StockStatus.inStock:
            return Color.appThemeGreenSwiftUI
        case L10n.ProductCell.StockStatus.limitedStock:
            return .gray
        case L10n.ProductCell.StockStatus.outOfStock:
            return .orange
        default:
            return .gray
        }
    }
    
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    private func formattedPrice(_ price: Double) -> String {
        let formatted = ProductCell.numberFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
        return formatted + "₾"
    }
    
    private func priceWithDealLabel(originalPrice: Double, newPrice: Double) -> some View {
        HStack {
            Text(formattedPrice(originalPrice))
                .foregroundColor(.gray)
                .strikethrough()
                .font(.system(size: Constants.priceFontSize, weight: .medium))
            
            Text(formattedPrice(newPrice))
                .foregroundColor(.black)
                .font(.system(size: Constants.priceFontSize, weight: .medium))
        }
    }
}
