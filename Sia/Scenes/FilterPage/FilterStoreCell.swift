//
//  FilterStoreCell.swift
//  Sia
//
//  Created by Sandro Gelashvili on 22.07.24.
//

import SwiftUI

struct FilterStoreCell: View {
    let storeName: String
    let imageURL: String
    let height: CGFloat
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .frame(height: height)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                }
                .onTapGesture {
                    onSelect()
                }
            
            HStack {
                AsyncImageView(imageURL: imageURL,
                               height: height - 20)
                .padding(.bottom)
                
                Text(storeName)
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.leading, 5)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)
                        .overlay {
                            Circle()
                                .stroke(Color("AppThemeGreen"), lineWidth: 1)
                        }
                    if isSelected {
                        Circle()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color("AppThemeGreen"))
                    }
                }
                .padding(.trailing)
            }
        }
        .padding(.horizontal)
    }
}
