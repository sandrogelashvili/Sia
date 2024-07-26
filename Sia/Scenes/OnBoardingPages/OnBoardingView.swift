//
//  OnBoardingView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 08.07.24.
//

import SwiftUI

private enum Constants {
    static let firstPage: Int = 1
    static let secondPage: Int = 2
    static let thirdPage: Int = 3
    static let totalPages: Int = 3
    static let currentPage: Int = 1
    
    enum ConstantsStrings {
        static let currentPageString: String = "currentPage"
    }
}

struct OnBoardingView: View {
    var totalPages = Constants.totalPages
    @AppStorage(Constants.ConstantsStrings.currentPageString) var currentPage = Constants.currentPage
    
    var body: some View {
        if currentPage > totalPages {
            TabBarView()
        } else {
            switch currentPage {
            case Constants.firstPage:
                OnBoardingReusablePage(
                    titleForOBPage: L10n.Onboarding.TitleForObPage1.text,
                    imageForOBPage: Image.imageForFirsObPage,
                    descriptionForOBPage: L10n.Onboarding.DescriptionForObPage1.text,
                    totalPages: totalPages,
                    currentPage: $currentPage,
                    isLastPage: false
                )
                
            case Constants.secondPage:
                OnBoardingReusablePage(
                    titleForOBPage: L10n.Onboarding.TitleForObPage2.text,
                    imageForOBPage: Image.imageForSecondObPage,
                    descriptionForOBPage: L10n.Onboarding.DescriptionForObPage2.text,
                    totalPages: totalPages,
                    currentPage: $currentPage,
                    isLastPage: false
                )
                
            case Constants.thirdPage:
                OnBoardingReusablePage(
                    titleForOBPage: L10n.Onboarding.TitleForObPage3.text,
                    imageForOBPage: Image.imageForThirdPage,
                    descriptionForOBPage: L10n.Onboarding.DescriptionForObPage3.text,
                    totalPages: totalPages,
                    currentPage: $currentPage,
                    isLastPage: true
                )
                
            default:
                EmptyView()
            }
        }
    }
}
