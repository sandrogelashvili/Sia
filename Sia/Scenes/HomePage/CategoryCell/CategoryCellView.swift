//
//  CategoryCellView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 13.07.24.
//

import SwiftUI

struct CategoryCellView: View {
    let categoryName: String
    let imageURL: String
    let color: Color
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .frame(height: 180)
            
            VStack {
                Text(categoryName)
                    .font(.headline)
                    .foregroundColor(.white)
                
                AsyncImageView(imageURL: imageURL, height: 130)
            }
        }
    }
}
