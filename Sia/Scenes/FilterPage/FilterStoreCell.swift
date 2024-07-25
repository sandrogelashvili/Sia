//
//  FilterStoreCell.swift
//  Sia
//
//  Created by Sandro Gelashvili on 22.07.24.
//

import SwiftUI

private enum FilterStoreCellConstants {
    static let cornerRadius: CGFloat = 10
    static let strokeOpacity: Double = 0.5
    static let strokeLineWidth: CGFloat = 1
    static let imagePaddingBottom: CGFloat = 20
    static let textFontSize: CGFloat = 20
    static let textFontWeight: Font.Weight = .bold
    static let textPaddingLeading: CGFloat = 5
    static let circleSize: CGFloat = 24
    static let innerCircleSize: CGFloat = 18
    static let circleStrokeLineWidth: CGFloat = 1
    static let circlePaddingTrailing: CGFloat = 10
    static let cellPaddingHorizontal: CGFloat = 10
}

struct FilterStoreCell: View {
    let storeName: String
    let imageURL: String
    let height: CGFloat
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: FilterStoreCellConstants.cornerRadius)
                .fill(.white)
                .frame(height: height)
                .overlay {
                    RoundedRectangle(cornerRadius: FilterStoreCellConstants.cornerRadius)
                        .stroke(Color.gray.opacity(FilterStoreCellConstants.strokeOpacity), lineWidth: FilterStoreCellConstants.strokeLineWidth)
                }
                .onTapGesture {
                    onSelect()
                }
            
            HStack {
                AsyncImageView(imageURL: imageURL,
                               height: height - FilterStoreCellConstants.imagePaddingBottom)
                .padding(.bottom)
                
                Text(storeName)
                    .foregroundColor(.black)
                    .font(.system(size: FilterStoreCellConstants.textFontSize, weight: FilterStoreCellConstants.textFontWeight))
                    .padding(.leading, FilterStoreCellConstants.textPaddingLeading)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .frame(width: FilterStoreCellConstants.circleSize, height: FilterStoreCellConstants.circleSize)
                        .foregroundColor(.white)
                        .overlay {
                            Circle()
                                .stroke(Color.appThemeGreenSwiftUI, lineWidth: FilterStoreCellConstants.circleStrokeLineWidth)
                        }
                    if isSelected {
                        Circle()
                            .frame(width: FilterStoreCellConstants.innerCircleSize, height: FilterStoreCellConstants.innerCircleSize)
                            .foregroundColor(Color.appThemeGreenSwiftUI)
                    }
                }
                .padding(.trailing, FilterStoreCellConstants.circlePaddingTrailing)
            }
        }
        .padding(.horizontal, FilterStoreCellConstants.cellPaddingHorizontal)
    }
}
