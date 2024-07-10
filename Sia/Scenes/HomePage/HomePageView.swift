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
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                SearchBarFilterRC(searchText: $searchText,
                                  filterAction: {
                    print("Filter")
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
                
                AsyncImage(url: URL(string: imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 130)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 130)
                            .padding(.leading, 16)
                            .padding(.bottom, -20)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 130)
                            .foregroundColor(.gray)
                            .padding(.leading, 16)
                            .padding(.bottom, -20)
                    @unknown default:
                        EmptyView()
                    }
                }
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
