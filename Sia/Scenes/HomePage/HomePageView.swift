//
//  HomePageView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 08.07.24.
//

import SwiftUI

struct HomePageView: View {
    @StateObject private var viewModel = HomePageViewModel()
    @State private var searchText = ""
    @State private var isFilterViewPresented = false
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                SearchBarFilterRC(searchText: $searchText,
                                  filterAction: {
                    withAnimation {
                        isFilterViewPresented = true
                    }
                })
                
                categoryText
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(viewModel.categories) { category in
                            CategoryView(categoryName: category.name,
                                         imageURL: category.categoryImageURL,
                                         color: Color(hex: category.backgroundColor) ?? .gray)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            if isFilterViewPresented {
                GeometryReader { geometry in
                    ZStack(alignment: .trailing) {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                withAnimation {
                                    isFilterViewPresented = false
                                }
                            }
                        
                        FilterView(isPresented: $isFilterViewPresented)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height)
                            .background(Color.white)
                            .cornerRadius(16)
                            .shadow(radius: 5)
                            .offset(x: isFilterViewPresented ? 0 : geometry.size.width)
                            .animation(.easeInOut)
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private var categoryText: some View {
        Text("აირჩიეთ კატოგორია")
            .padding(.leading, 20)
            .font(.system(size: 20, weight: .semibold))
    }
}

private struct CategoryView: View {
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
                
                AsyncImageView(imageURL: imageURL,
                               height: 130)
            }
        }
    }
}

extension Color {
    init?(hex: String) {
        let r, g, b: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat(hexNumber & 0x0000ff) / 255
                    
                    self.init(red: r, green: g, blue: b)
                    return
                }
            }
        }
        return nil
    }
}

#Preview {
    HomePageView()
}
