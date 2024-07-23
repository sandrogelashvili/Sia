//
//  FilterView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import SwiftUI

struct FilterView: View {
    @Binding var isPresented: Bool
    @Binding var selectedStoreId: String?
    @StateObject private var viewModel = FilterViewModel()
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 50)
            
            HStack {
                Text("მაღაზიების მიხედვით")
                    .font(.system(size: 20, weight: .semibold))
                
                Spacer()
                
                cancelButton
            }
            .padding()
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(viewModel.stores) { store in
                        FilterStoreCell(storeName: store.name,
                                        imageURL: store.storeImageURL,
                                        height: 50,
                                        isSelected: selectedStoreId == store.id,
                                        onSelect: {
                            if selectedStoreId == store.id {
                                selectedStoreId = nil
                            } else {
                                selectedStoreId = store.id
                            }
                        })
                    }
                }
                Divider()
                
                HStack {
                    Text("ფასის მიხედვით")
                        .font(.system(size: 20, weight: .semibold))
                    
                    Spacer()
                }
                .padding()
            }
            Spacer()
            
        }
        .background(Color("BackgroundColor"))
    }
    
    private var cancelButton: some View {
        Button(action: {
            isPresented = false
        }) {
            Image(systemName: "x.circle.fill")
                .foregroundColor(.gray)
                .font(.largeTitle)
        }
    }
}

