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
        VStack {
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
                .padding()
            }
            
            HStack(alignment: .center) {
                textForTitle
            }
            .padding()
            
            Spacer()
            
            onBoardingImage
            
            Spacer()
            
            textForDescription
            
            indicatorBar
                .padding()
            
            nextButton
        }
    }
    
    private var backButton: some View {
        Button {
            currentPage -= 1
        } label: {
            Image(systemName: "chevron.left")
                .foregroundStyle(.black)
            Text("Back")
                .foregroundStyle(.black)
        }
    }
    
    private var skipButton: some View {
        Button {
            currentPage = totalPages + 1
        } label: {
            Text("Skip")
                .foregroundStyle(.black)
        }
    }
    
    private var textForTitle: some View {
        Text(titleForOBPage)
            .font(.title)
            .fontWeight(.medium)
    }
    
    private var onBoardingImage: some View {
        Image(imageForOBPage)
            .resizable()
            .scaledToFit()
    }
    
    private var textForDescription: some View {
        Text(descriptionForOBPage)
            .padding()
            .font(.system(size: 16, weight: .regular))
            .multilineTextAlignment(.center)
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
                .frame(height: 50)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color("AppThemeGreen"))
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .padding()
        }
    }
    
    private var indicatorBar: some View {
        HStack {
            ForEach(1...totalPages, id: \.self) { index in
                indicator(for: index)
            }
        }
    }
    
    private func indicator(for index: Int) -> some View {
        Color(index == currentPage ? Color("AppThemeGreen") : .black)
            .frame(height: 8 / UIScreen.main.scale)
    }
}

