//
//  FilterView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import SwiftUI

struct FilterView: View {
    @Binding var isPresented: Bool
    @StateObject private var viewModel = FilterViewModel()
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 50)
            
            HStack {
                Text("მაღაზიების მიხედვით")
                    .font(.system(size: 24, weight: .semibold))
                
                Spacer()
                
                cancelButton
            }
            .padding()
            ScrollView {
                VStack {
                    ForEach(viewModel.stores) { store in
                        StoreFilterCell(storeName: store.name,
                                        imageURL: store.storeImageURL,
                                        height: 100,
                                        backgroundColor: backgroundColor(for: store.name))
                    }
                }
                Divider()
                
                HStack {
                    Text("ფასის მიხედვით")
                        .font(.system(size: 24, weight: .semibold))
                    
                    Spacer()
                }
                .padding()
            }
            
            Spacer()
        }
    }
    
    private struct StoreFilterCell: View {
        let storeName: String
        let imageURL: String
        let height: CGFloat
        let backgroundColor: Color
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(backgroundColor)
                    .frame(height: height)
                
                HStack {
                    AsyncImageView(imageURL: imageURL,
                                   height: height - 20)
                    .padding(.bottom)
                    .shadow(radius: 10)
                    
                    Text(storeName)
                        .foregroundColor(.white)
                        .font(.system(size: 33, weight: .medium))
                        .padding(.leading)
                    
                    Spacer()
                }
            }
            .padding()
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
    
    private func backgroundColor(for storeName: String) -> Color {
        switch storeName.lowercased() {
        case "ნიკორა":
            return Color(#colorLiteral(red: 0.9244207144,
                                       green: 0.1990495324,
                                       blue: 0.2151132822,
                                       alpha: 1))
        case "აგროჰაბი":
            return Color(#colorLiteral(red: 0.227994889,
                                       green: 0.6997299194,
                                       blue: 0.2792698145,
                                       alpha: 1))
        default:
            return Color.gray.opacity(0.2)
        }
    }
}

#Preview {
    FilterView(isPresented: .constant(false))
}
