//
//  FilterStoreCell.swift
//  Sia
//
//  Created by Sandro Gelashvili on 22.07.24.
//

import SwiftUI

private enum Constants {
    static let strokeOpacity: Double = 0.5
    static let textFontSize: CGFloat = 16
}

struct FilterStoreCell: View {
    let storeName: String
    let imageURL: String
    let height: CGFloat
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Grid.CornerRadius.textField)
                .fill(.white)
                .frame(height: height)
                .overlay {
                    RoundedRectangle(cornerRadius: Grid.CornerRadius.textField)
                        .stroke(Color.gray.opacity(Constants.strokeOpacity), lineWidth: Grid.BorderWidth.regular)
                }
                .onTapGesture {
                    onSelect()
                }
            
            HStack {
                AsyncImageView(imageURL: imageURL,
                               height: height - Grid.Spacing.l)
                .padding(.bottom)
                
                Text(storeName)
                    .foregroundColor(.black)
                    .font(.system(size: Constants.textFontSize, weight: .semibold))
                    .padding(.leading, Grid.Spacing.xs2)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .frame(width: Grid.Spacing.xl, height: Grid.Spacing.xl)
                        .foregroundColor(.white)
                        .overlay {
                            Circle()
                                .stroke(Color.appThemeGreenSwiftUI, lineWidth: Grid.BorderWidth.regular)
                        }
                    if isSelected {
                        Circle()
                            .frame(width: Grid.Spacing.l, height: Grid.Spacing.l)
                            .foregroundColor(Color.appThemeGreenSwiftUI)
                    }
                }
                .padding(.trailing, Grid.Spacing.s)
            }
        }
        .padding(.horizontal, Grid.Spacing.s)
    }
}
