//
//  AsyncImageView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 11.07.24.
//

import SwiftUI

struct AsyncImageView: View {
    let imageURL: String
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(height: height)
                    .frame(height: height)
                    .padding(.leading, 16)
                    .padding(.bottom, -20)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: height)
                    .padding(.leading, 16)
                    .padding(.bottom, -20)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: height)
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
                    .padding(.bottom, -20)
            @unknown default:
                EmptyView()
            }
        }
    }
}
