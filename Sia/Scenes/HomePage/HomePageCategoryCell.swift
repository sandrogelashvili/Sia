//
//  CategoryCellView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 13.07.24.
//

import SwiftUI

private enum Constants {
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
            RoundedRectangle(cornerRadius: Grid.CornerRadius.textField)
                .fill(color)
                .frame(height: Constants.cellHeight)
            
            VStack {
                Text(categoryName)
                    .font(.headline)
                    .foregroundColor(.white)
                
                AsyncImageView(imageURL: imageURL, height: Constants.imageHeight)
            }
        }
    }
}
