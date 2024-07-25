//
//  CategoryCellView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 13.07.24.
//

import SwiftUI

private enum HomePageCategoryConstants {
    static let roundedRectCornerRadius: CGFloat = 10
    static let cellHeight: CGFloat = 180
    static let imageHeight: CGFloat = 130
}

struct HomePageCategoryCell: View {
    let categoryName: String
    let imageURL: String
    let color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: HomePageCategoryConstants.roundedRectCornerRadius)
                .fill(color)
                .frame(height: HomePageCategoryConstants.cellHeight)
            
            VStack {
                Text(categoryName)
                    .font(.headline)
                    .foregroundColor(.white)
                
                AsyncImageView(imageURL: imageURL, height: HomePageCategoryConstants.imageHeight)
            }
        }
    }
}
