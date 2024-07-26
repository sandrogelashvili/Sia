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
                    .padding(.leading, Grid.Spacing.m)
                    .padding(.bottom, -Grid.Spacing.l)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: height)
                    .padding(.leading, Grid.Spacing.m)
                    .padding(.bottom, -Grid.Spacing.l)
            case .failure:
                Image .loaderPhoto
                    .resizable()
                    .scaledToFit()
                    .frame(height: height)
                    .foregroundColor(.gray)
                    .padding(.leading, Grid.Spacing.m)
                    .padding(.bottom, -Grid.Spacing.l)
            @unknown default:
                EmptyView()
            }
        }
    }
}
