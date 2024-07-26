//
//  OnBoardingReusableView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 08.07.24.
//

import SwiftUI

private enum Constants {
    static let titleFontSize: CGFloat = 30
    static let descriptionFontSize: CGFloat = 14
    static let animationDuration: Double = 1.0
    static let animationDelay: Double = 0.3
    static let animationOpacity: Double = 1.0
    static let gradientOpacity: Double = 0.8
    static let nextButtonHeight: CGFloat = 58.5
    
    enum ConstantsStrings {
        static let titleFont: String = "Helvetica"
    }
}

struct OnBoardingReusablePage: View {
    var titleForOBPage: String
    var imageForOBPage: Image
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
                    .padding(.bottom, Grid.Spacing.s)
                    .opacity(animate ? Constants.animationOpacity : .zero)
                    .offset(y: animate ? .zero : Grid.Spacing.l)
                    .animation(.easeInOut(duration: Constants.animationDuration), value: animate)
                
                textForDescription
                    .padding(.bottom, Grid.Spacing.xl4)
                    .opacity(animate ? Constants.animationOpacity : .zero)
                    .offset(y: animate ? .zero : Grid.Spacing.l)
                    .animation(.easeInOut(duration: Constants.animationDuration).delay(Constants.animationDelay), value: animate)
                
                HStack {
                    indicatorBar
                        .padding(.vertical)
                        .opacity(animate ? Constants.animationOpacity : .zero)
                        .offset(y: animate ? .zero : Grid.Spacing.l)
                        .animation(.easeInOut(duration: Constants.animationDuration).delay(Constants.animationDelay * 2), value: animate)
                    
                    Spacer()
                }
                
                nextButton
                    .opacity(animate ? Constants.animationOpacity : .zero)
                    .offset(y: animate ? .zero : Grid.Spacing.l)
                    .animation(.easeInOut(duration: Constants.animationDuration).delay(Constants.animationDelay * 3), value: animate)
            }
            .padding(.horizontal, Grid.Spacing.xl4 * 2)
        }
        .onAppear {
            animate = true
        }
    }
    
    private var onBoardingImage: some View {
        ZStack {
            imageForOBPage
                .resizable()
                .scaledToFill()
                .scaleEffect(animate ? 1 : 1.1)
                .animation(.easeInOut(duration: Constants.animationDuration), value: animate)
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(Constants.gradientOpacity), .clear]),
                startPoint: .bottom,
                endPoint: .top
            )
        }
    }
    
    private var textForTitle: some View {
        Text(titleForOBPage)
            .font(.custom(Constants.ConstantsStrings.titleFont, size: Constants.titleFontSize))
            .foregroundColor(.white)
    }
    
    private var textForDescription: some View {
        Text(descriptionForOBPage)
            .font(.custom(Constants.ConstantsStrings.titleFont, size: Constants.descriptionFontSize))
            .foregroundStyle(.white)
    }
    
    private var nextButton: some View {
        Button {
            nextPage()
        } label: {
            Text(isLastPage ? L10n.Onboarding.Button.start : L10n.Onboarding.Button.next)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(height: Constants.nextButtonHeight)
                .frame(minWidth: .zero, maxWidth: .infinity)
                .background(Color.appThemeGreenSwiftUI)
                .clipShape(RoundedRectangle(cornerRadius: Grid.CornerRadius.button))
                .padding(.bottom, Grid.Spacing.xl4)
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
            .frame(width: Grid.Spacing.xs, height: Grid.Spacing.xs)
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
