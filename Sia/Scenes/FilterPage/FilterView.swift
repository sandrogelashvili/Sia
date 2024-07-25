//
//  FilterView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import SwiftUI

private enum FilterViewConstants {
    static let topSpacerHeight: CGFloat = 50
    static let sectionFontSize: CGFloat = 20
    static let verticalSpacing: CGFloat = 10
    static let storeCellHeight: CGFloat = 50
    static let horizontalPadding: CGFloat = 10
}

struct FilterView: View {
    @Binding var isPresented: Bool
    @Binding var selectedStoreId: String?
    @StateObject private var viewModel = FilterViewModel()
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: FilterViewConstants.topSpacerHeight)

            HStack {
                Text(L10n.Filterview.byStores)
                    .font(.system(size: FilterViewConstants.sectionFontSize, weight: .semibold))
                
                Spacer()
                
                cancelButton
            }
            .padding(.horizontal, FilterViewConstants.horizontalPadding)
            
            ScrollView {
                VStack(spacing: FilterViewConstants.verticalSpacing) {
                    ForEach(viewModel.stores) { store in
                        FilterStoreCell(
                            storeName: store.name,
                            imageURL: store.storeImageURL,
                            height: FilterViewConstants.storeCellHeight,
                            isSelected: selectedStoreId == store.id,
                            onSelect: {
                                if selectedStoreId == store.id {
                                    selectedStoreId = nil
                                } else {
                                    selectedStoreId = store.id
                                }
                            }
                        )
                    }
                }
                Divider()
                
                HStack {
                    Text(L10n.Filterview.byPrice)
                        .font(.system(size: FilterViewConstants.sectionFontSize, weight: .semibold))
                    
                    Spacer()
                }
                .padding(.horizontal, FilterViewConstants.horizontalPadding)
            }
            Spacer()
        }
        .background(Color.gray400SwiftUI)
    }
    
    private var cancelButton: some View {
        Button(action: {
            isPresented = false
        }) {
            Image.iconForCancelButton
                .foregroundColor(Color.gray)
                .font(.title3)
        }
    }
}

