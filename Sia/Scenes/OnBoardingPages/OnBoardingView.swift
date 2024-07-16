//
//  OnBoardingView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 08.07.24.
//

import SwiftUI

struct OnBoardingView: View {
    var totalPages = 3
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        if currentPage > totalPages {
            TabBarView()
        } else {
            if currentPage == 1 {
                OnBoardingReusablePage(
                    titleForOBPage: "პროდუქტების ძიების მარტივი გზა",
                    imageForOBPage: "Onboarding21",
                    descriptionForOBPage: "მოძებნე სასურველი პროდუქტი, გაფილტრე კატეგორიების ან მაღაზიების მიხედვით",
                    totalPages: totalPages,
                    currentPage: $currentPage,
                    isLastPage: false
                )
            }
            
            if currentPage == 2 {
                OnBoardingReusablePage(
                    titleForOBPage: "შექმენი შენი სია",
                    imageForOBPage: "onBoarding22",
                    descriptionForOBPage: "შეადარეთ ფასები და შექმენით პერსონალური პროდუქტების სია მარტივად",
                    totalPages: totalPages,
                    currentPage: $currentPage,
                    isLastPage: false
                )
            }
            
            if currentPage == 3 {
                OnBoardingReusablePage(
                    titleForOBPage: "დაზოგე ფული და დრო",
                    imageForOBPage: "Onboarding20",
                    descriptionForOBPage: "იხილეთ ინფორმაცია მაღაზიების მიმდინარე შეთავაზებების შესახებ",
                    totalPages: totalPages,
                    currentPage: $currentPage,
                    isLastPage: true
                )
            }
        }
    }
}



#Preview {
    OnBoardingView()
}
