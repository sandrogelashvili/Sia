//
//  OnBoardingReusableView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 08.07.24.
//

import SwiftUI

private enum OBReusablePageConstants {
    static let titleFont: String = "Helvetica"
    static let titleFontSize: CGFloat = 30
    static let descriptionFontSize: CGFloat = 14
    static let animationDuration: Double = 1.0
    static let animationDelay: Double = 0.3
    static let animationOpacity: Double = 1.0
    static let nextButtonHeight: CGFloat = 58.5
    static let nextButtonCornerRadius: CGFloat = 15
    static let nextButtonBottomPadding: CGFloat = 30
    static let indicatorSize: CGFloat = 8
    static let titleBottomPadding: CGFloat = 10
    static let descriptionBottomPadding: CGFloat = 30
    static let elementOffset: CGFloat = 20
    static let horizontalPadding: CGFloat = 75
    static let gradientOpacity: Double = 0.8
}

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
                            if value.translation.width < .zero {
                                nextPage()
                            } else if value.translation.width > .zero {
                                previousPage()
                            }
                        }
                )
            
            VStack(alignment: .leading) {
                Spacer()
                
                textForTitle
                    .padding(.bottom, OBReusablePageConstants.titleBottomPadding)
                    .opacity(animate ? OBReusablePageConstants.animationOpacity : .zero)
                    .offset(y: animate ? .zero : OBReusablePageConstants.elementOffset)
                    .animation(.easeInOut(duration: OBReusablePageConstants.animationDuration), value: animate)
                
                textForDescription
                    .padding(.bottom, OBReusablePageConstants.descriptionBottomPadding)
                    .opacity(animate ? OBReusablePageConstants.animationOpacity : .zero)
                    .offset(y: animate ? .zero : OBReusablePageConstants.elementOffset)
                    .animation(.easeInOut(duration: OBReusablePageConstants.animationDuration).delay(OBReusablePageConstants.animationDelay), value: animate)
                
                HStack {
                    indicatorBar
                        .padding(.vertical)
                        .opacity(animate ? OBReusablePageConstants.animationOpacity : .zero)
                        .offset(y: animate ? .zero : OBReusablePageConstants.elementOffset)
                        .animation(.easeInOut(duration: OBReusablePageConstants.animationDuration).delay(OBReusablePageConstants.animationDelay * 2), value: animate)
                    
                    Spacer()
                }
                
                nextButton
                    .opacity(animate ? OBReusablePageConstants.animationOpacity : .zero)
                    .offset(y: animate ? .zero : OBReusablePageConstants.elementOffset)
                    .animation(.easeInOut(duration: OBReusablePageConstants.animationDuration).delay(OBReusablePageConstants.animationDelay * 3), value: animate)
            }
            .padding(.horizontal, OBReusablePageConstants.horizontalPadding)
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
                .animation(.easeInOut(duration: OBReusablePageConstants.animationDuration), value: animate)
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(OBReusablePageConstants.gradientOpacity), .clear]),
                startPoint: .bottom,
                endPoint: .top
            )
        }
    }
    
    private var textForTitle: some View {
        Text(titleForOBPage)
            .font(.custom(OBReusablePageConstants.titleFont, size: OBReusablePageConstants.titleFontSize))
            .foregroundColor(.white)
    }
    
    private var textForDescription: some View {
        Text(descriptionForOBPage)
            .font(.custom(OBReusablePageConstants.titleFont, size: OBReusablePageConstants.descriptionFontSize))
            .foregroundStyle(.white)
    }
    
    private var nextButton: some View {
        Button {
            nextPage()
        } label: {
            Text(isLastPage ? "დაწყება" : "შემდეგი")
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(height: OBReusablePageConstants.nextButtonHeight)
                .frame(minWidth: .zero, maxWidth: .infinity)
                .background(Color.appThemeGreenSwiftUI)
                .clipShape(RoundedRectangle(cornerRadius: OBReusablePageConstants.nextButtonCornerRadius))
                .padding(.bottom, OBReusablePageConstants.nextButtonBottomPadding)
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
            .frame(width: OBReusablePageConstants.indicatorSize, height: OBReusablePageConstants.indicatorSize)
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
