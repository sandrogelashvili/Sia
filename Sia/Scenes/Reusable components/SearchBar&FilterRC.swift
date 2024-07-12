//
//  SearchBar&FilterRC.swift
//  Sia
//
//  Created by Sandro Gelashvili on 10.07.24.
//

import SwiftUI

struct SearchBarFilterRC: View {
    @Binding var searchText: String
    var filterAction: () -> Void
    var searchAction: () -> Void
    
    var body: some View {
        HStack {
            HStack {
                searchBarImage
                
                searchBarTextField
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 0.2)
            )
            .padding()
            .overlay {
                HStack {
                    Spacer()
                    
                    clearButton
                }
            }
            ZStack {
                filterBackground
                
                Image("Filter")
                    .onTapGesture {
                        filterAction()
                    }
            }
            .padding(.trailing)
        }
    }
    
    private var searchBarImage: some View {
        Image(systemName: "magnifyingglass")
            .foregroundColor(.gray)
            .padding(.leading, 10)
    }
    
    private var searchBarTextField: some View {
        TextField("ძებნა", text: $searchText, onCommit: { searchAction() })
            .padding(7)
            .padding(.leading, -7)
            .frame(height: 45)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private var clearButton: some View {
        Button {
            searchText = ""
        } label: {
            Label("clear", systemImage: "xmark.circle.fill")
                .foregroundColor(.gray)
                .opacity(searchText.isEmpty ? 0 : 1)
                .padding(30)
        }
        .labelStyle(.iconOnly)
    }
    
    private var filterBackground: some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: 46, height: 46)
            .foregroundStyle(.white)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 0.5)
            )
    }
}

//#Preview {
//    SearchBarFilterRC()
//}
