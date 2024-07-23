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
    
    @State private var animate = false
    
    var body: some View {
        ZStack {
            onBoardingImage
                .edgesIgnoringSafeArea(.all)
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < 0 {
                                nextPage()
                            } else if value.translation.width > 0 {
                                previousPage()
                            }
                        }
                )
            
            VStack(alignment: .leading) {
                Spacer()
                
                textForTitle
                    .padding(.bottom, 10)
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 1.0), value: animate)
                
                textForDescription
                    .padding(.bottom, 30)
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 1.0).delay(0.3), value: animate)
                
                HStack {
                    indicatorBar
                        .padding(.vertical)
                        .opacity(animate ? 1 : 0)
                        .offset(y: animate ? 0 : 20)
                        .animation(.easeInOut(duration: 1.0).delay(0.6), value: animate)
                    
                    Spacer()
                }
                
                nextButton
                    .opacity(animate ? 1 : 0)
                    .offset(y: animate ? 0 : 20)
                    .animation(.easeInOut(duration: 1.0).delay(0.9), value: animate)
            }
            .padding(.horizontal, 75)
        }
        .onAppear {
            animate = true
        }
    }
    
    private var onBoardingImage: some View {
        ZStack {
            Image(imageForOBPage)
                .resizable()
                .scaledToFill()
                .scaleEffect(animate ? 1 : 1.1)
                .animation(.easeInOut(duration: 1.0), value: animate)
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.8), .clear]),
                startPoint: .bottom,
                endPoint: .top
            )
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
            nextPage()
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
            .frame(width: 8, height: 8)
    }
    
    private func nextPage() {
        if isLastPage {
            currentPage = totalPages + 1
        } else {
            currentPage += 1
        }
    }
    
    private func previousPage() {
        if currentPage > 1 {
            currentPage -= 1
        }
    }
}
