//
//  SearchBarFilterView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 10.07.24.
//

import SwiftUI

private enum Constants {
    static let trailingPadding: CGFloat = 10
    
    enum ConstantsStrings {
        static let iconCancelButton: String = "xmark.circle.fill"
    }
}

struct SearchBarFilterView: View {
    @Binding var searchText: String
    var filterAction: () -> Void
    var searchAction: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                searchBarImage
                searchBarTextField
            }
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: Grid.CornerRadius.textField)
                    .stroke(Color.black, lineWidth: Grid.BorderWidth.extraThin)
            )
            .padding()
            .overlay(
                HStack {
                    Spacer()
                    clearButton
                }
                    .padding(.trailing, Grid.Spacing.xs)
            )
            
            ZStack {
                filterBackground
                
                Image.iconFilter
                    .onTapGesture {
                        filterAction()
                    }
            }
            .padding(.trailing, Grid.Spacing.xs)
        }
    }
    
    private var searchBarImage: some View {
        Image.iconSearch
            .foregroundColor(.gray)
            .padding(.leading, Grid.Spacing.xs)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: Grid.CornerRadius.textField))
    }
    
    private var searchBarTextField: some View {
        TextField(L10n.SearchBar.FilterView.searchPlaceholder, text: $searchText, onEditingChanged: { _ in searchAction() })
            .padding(Grid.Spacing.xs)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: Grid.CornerRadius.textField))
            .frame(height: Grid.Spacing.xl5)
    }
    
    private var clearButton: some View {
        Button {
            searchText = ""
        } label: {
            Label(L10n.SearchBar.FilterView.clear, systemImage: Constants.ConstantsStrings.iconCancelButton)
                .foregroundColor(.gray)
                .opacity(searchText.isEmpty ? .zero : 1)
                .padding(Grid.Spacing.xl3)
        }
        .labelStyle(.iconOnly)
    }
    
    private var filterBackground: some View {
        RoundedRectangle(cornerRadius: Grid.CornerRadius.filter)
            .frame(width: Grid.Spacing.xl5, height: Grid.Spacing.xl5)
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: Grid.CornerRadius.filter)
                    .stroke(Color.black, lineWidth: Grid.BorderWidth.thin)
            )
    }
}
