//
//  ProductCollectionViewCell.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import SwiftUI

struct ProductCell: View {
    let productName: String
    let productImageURL: String
    let stockStatus: String
    let price: Double
    let storeName: String
    let storeImageUrl: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
            
            VStack {
                productNameLabel
                    .padding(.top)
                
                ZStack {
                    productImageView
                    
                    HStack {
                        Spacer()
                        
                        stockStatusLabel
                            .offset(y: -40)
                    }
                }
                Spacer()
                HStack (alignment: .bottom){
                    VStack {
                        HStack {
                            storeImageForCell
                            
                            storeNameForCell
                                .offset(y: 10.0)
                        }
                        .padding(.leading, -20)
                        
                        priceLabel
                            .padding(.top, 10)
                    }
                    Spacer()
                    favoriteButton
                        .padding(.trailing, 10)
                }
                .padding(.leading, 10)
                .padding(.bottom, 10)
                
            }
        }
        .background(Color.white)
        .frame(width: 170, height: 230)
        .cornerRadius(8)
        .shadow(radius: 1)
        .padding(5)
    }
    
    
    private var productNameLabel: some View {
        Text(productName)
            .foregroundColor(.black)
            .font(.system(size: 14, weight: .semibold))
            .multilineTextAlignment(.center)
    }
    
    private var productImageView: some View {
        AsyncImageView(imageURL: productImageURL, height: 110)
    }
    
    private var stockStatusLabel: some View {
        Text(stockStatus)
            .foregroundColor(stockStatusColor)
            .font(.system(size: 10, weight: .semibold))
            .frame(width: 60, height: 20)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5)
    }
    
    private var storeImageForCell: some View {
        AsyncImageView(imageURL: storeImageUrl, height: 20)
    }
    
    private var storeNameForCell: some View {
        Text(storeName)
            .foregroundColor(.gray)
            .font(.system(size: 12))
    }
    
    private var priceLabel: some View {
        Text(formattedPrice)
            .foregroundColor(.black)
            .font(.system(size: 14, weight: .medium))
        
    }
    
    private var favoriteButton: some View {
        Button(action: {
            print("Button tapped!")
        }) {
            Image(systemName: "heart")
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
                .background(Color("AppThemeGreen"))
                .cornerRadius(5)
        }
    }
    
    private var stockStatusColor: Color {
        switch stockStatus {
        case "მარაგშია":
            return Color("AppThemeGreen")
        case "მარაგი ამოიწურა":
            return .gray
        case "მარაგი იწურება":
            return .orange
        default:
            return .gray
        }
    }
    
    private var formattedPrice: String {
        let formatted = ProductCell.numberFormatter.string(from: NSNumber(value: price)) ?? "\(price)"
        return formatted + "₾"
    }
    
    private static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}
