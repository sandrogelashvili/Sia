//
//  OnBoardingView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 08.07.24.
//

import SwiftUI

private enum OBConstants {
    static let firstPage: Int = 1
    static let secondPage: Int = 2
    static let thirdPage: Int = 3
    static let totalPages: Int = 3
    static let currentPage: Int = 1
}

struct OnBoardingView: View {
    var totalPages = OBConstants.totalPages
    @AppStorage("currentPage") var currentPage = OBConstants.currentPage
    
    var body: some View {
        if currentPage > totalPages {
            TabBarView()
        } else {
            switch currentPage {
            case OBConstants.firstPage:
                OnBoardingReusablePage(
                    titleForOBPage: L10n.Onboarding.TitleForObPage1.text,
                    imageForOBPage: "Onboarding21",
                    descriptionForOBPage: L10n.Onboarding.DescriptionForObPage1.text,
                    totalPages: totalPages,
                    currentPage: $currentPage,
                    isLastPage: false
                )
                
            case OBConstants.secondPage:
                OnBoardingReusablePage(
                    titleForOBPage: L10n.Onboarding.TitleForObPage2.text,
                    imageForOBPage: "onBoarding22",
                    descriptionForOBPage: L10n.Onboarding.DescriptionForObPage2.text,
                    totalPages: totalPages,
                    currentPage: $currentPage,
                    isLastPage: false
                )
                
            case OBConstants.thirdPage:
                OnBoardingReusablePage(
                    titleForOBPage: L10n.Onboarding.TitleForObPage3.text,
                    imageForOBPage: "Onboarding20",
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
