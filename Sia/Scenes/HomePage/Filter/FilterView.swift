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
                        StoreFilterCell(storeName: store.name,
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
    
    private struct StoreFilterCell: View {
        let storeName: String
        let imageURL: String
        let height: CGFloat
        let isSelected: Bool
        let onSelect: () -> Void
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(height: height)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    }
                    .onTapGesture {
                        onSelect()
                    }
                
                HStack {
                    AsyncImageView(imageURL: imageURL,
                                   height: height - 20)
                    .padding(.bottom)
                    
                    Text(storeName)
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.leading, 5)
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.white)
                            .overlay {
                                Circle()
                                    .stroke(Color("AppThemeGreen"), lineWidth: 1)
                            }
                        if isSelected {
                            Circle()
                                .frame(width: 18, height: 18)
                                .foregroundColor(Color("AppThemeGreen"))
                        }
                    }
                    .padding(.trailing)
                }
            }
            .padding(.horizontal)
        }
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

