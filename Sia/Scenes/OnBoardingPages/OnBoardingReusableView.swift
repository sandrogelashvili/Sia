//
//  OnBoardingReusableView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 08.07.24.
//

import SwiftUI

struct OnBoardingReusablePage: View {
    var titleForOBPage: String
    var imageForOBPage: String
    var descriptionForOBPage: String
    var totalPages: Int
    @Binding var currentPage: Int
    var isLastPage: Bool
    
    var body: some View {
        ZStack {
            onBoardingImage
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading){
                if currentPage == 1 {
                    HStack {
                        Spacer()
                        
                        skipButton
                    }
                    .padding()
                } else {
                    
                    HStack {
                        backButton
                        
                        Spacer()
                        
                        skipButton
                    }
                }
                Spacer()
                
                textForTitle
                    .padding(.bottom, 10)
                
                textForDescription
                    .padding(.bottom, 30)
                
                HStack {
                    indicatorBar
                        .padding(.vertical)
                    
                    Spacer()
                }
                
                nextButton
            }
            .padding(.horizontal, 75)
        }
    }
    
    private var onBoardingImage: some View {
        ZStack {
            Image(imageForOBPage)
                .resizable()
                .scaledToFill()
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.8), .clear]),
                startPoint: .bottom,
                endPoint: .top
            )
        }
    }
    
    private var backButton: some View {
        Button {
            currentPage -= 1
        } label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(.blue)
            Text("Back")
                .foregroundStyle(.blue)
        }
    }
    
    private var skipButton: some View {
        Button {
            currentPage = totalPages + 1
        } label: {
            Text("Skip")
                .foregroundStyle(.blue)
        }
    }
    
    private var textForTitle: some View {
        Text(titleForOBPage)
            .font(.custom("Helvetica", size: 30))
            .foregroundColor(.white)
    }
    
    private var textForDescription: some View {
        Text(descriptionForOBPage)
            .font(.custom("Helvetica", size: 14))
            .foregroundStyle(.white)
    }
    
    private var nextButton: some View {
        Button {
            if self.isLastPage {
                self.currentPage = self.totalPages + 1
            } else {
                self.currentPage += 1
            }
        } label: {
            Text(isLastPage ? "დაწყება" : "შემდეგი")
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(height: 58.5)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color("AppThemeGreen"))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.bottom)
        }
    }
    
    private var indicatorBar: some View {
        HStack {
            ForEach(1...totalPages, id: \.self) { index in
                indicator(for: index)
            }
        }
        .padding(.horizontal)
    }
    
    private func indicator(for index: Int) -> some View {
        Circle()
            .fill(index == currentPage ? Color.white : Color.gray)
            .frame(width: 12, height: 12)
    }
}

