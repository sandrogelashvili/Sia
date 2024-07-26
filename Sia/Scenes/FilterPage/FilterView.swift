//
//  FilterView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import SwiftUI

private enum Constants {
    static let sectionFontSize: CGFloat = 16
    static let scrollViewTopPadding: CGFloat = 70
}

struct FilterView: View {
    @Binding var isPresented: Bool
    @Binding var selectedStoreId: String?
    @Binding var selectedPriceSortOption: PriceSortOption?
    @StateObject private var viewModel = FilterViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                Divider()
                
                storeFilterSection
                
                Divider()
                    .padding(.top)
                
                priceFilterSection
                
                Divider()
                
                Spacer()
            }
            .padding(.horizontal, Grid.Spacing.s)
        }
        .background(Color.gray400SwiftUI)
        .padding(.top, Constants.scrollViewTopPadding)
    }
    
    private var storeFilterSection: some View {
        VStack(spacing: Grid.Spacing.s) {
            HStack {
                Text(L10n.FilterView.byStores)
                    .font(.system(size: Constants.sectionFontSize, weight: .semibold))
                
                Spacer()
            }
            .padding(.horizontal, Grid.Spacing.s)
            
            ForEach(viewModel.stores) { store in
                FilterStoreCell(
                    storeName: store.name,
                    imageURL: store.storeImageURL,
                    height: Grid.Spacing.xl5,
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
    }
    
    private var priceFilterSection: some View {
        VStack(spacing: Grid.Spacing.s) {
            HStack {
                Text(L10n.FilterView.byPrice)
                    .font(.system(size: Constants.sectionFontSize, weight: .semibold))
                
                Spacer()
            }
            .padding(.horizontal, Grid.Spacing.s)
            
            HStack(spacing: Grid.Spacing.s) {
                lowToHighButton
                highToLowButton
            }
            .padding(.horizontal, Grid.Spacing.s)
        }
    }
    
    private var lowToHighButton: some View {
        Button(action: {
            if selectedPriceSortOption == .lowToHigh {
                selectedPriceSortOption = nil
            } else {
                selectedPriceSortOption = .lowToHigh
            }
        }) {
            Text(L10n.FilterView.lowToHighPrice)
                .font(.system(size: Constants.sectionFontSize))
                .padding(Grid.Spacing.xs)
                .frame(height: Grid.Spacing.xl4)
                .background(selectedPriceSortOption == .lowToHigh ? Color.appThemeGreenSwiftUI: .white)
                .foregroundColor(selectedPriceSortOption == .lowToHigh ? Color.white : Color.black)
                .cornerRadius(Grid.CornerRadius.filter)
                .overlay(
                    RoundedRectangle(cornerRadius: Grid.CornerRadius.button)
                        .stroke(Color.appThemeGreenSwiftUI, lineWidth: selectedPriceSortOption == .lowToHigh ? .zero : 2)
                )
        }
    }
    
    private var highToLowButton: some View {
        Button(action: {
            if selectedPriceSortOption == .highToLow {
                selectedPriceSortOption = nil
            } else {
                selectedPriceSortOption = .highToLow
            }
        }) {
            Text(L10n.FilterView.highToLowPrice)
                .font(.system(size: Constants.sectionFontSize))
                .padding(Grid.Spacing.xs)
                .frame(height: Grid.Spacing.xl4)
                .background(selectedPriceSortOption == .highToLow ? Color.appThemeGreenSwiftUI : .white)
                .foregroundColor(selectedPriceSortOption == .highToLow ? Color.white : Color.black)
                .cornerRadius(Grid.CornerRadius.filter)
                .overlay(
                    RoundedRectangle(cornerRadius: Grid.CornerRadius.button)
                        .stroke(Color.appThemeGreenSwiftUI, lineWidth: selectedPriceSortOption == .highToLow ? .zero : 2)
                )
        }
    }
}
