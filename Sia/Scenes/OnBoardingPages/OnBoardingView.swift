//
//  OnBoardingView.swift
//  Sia
//
//  Created by Sandro Gelashvili on 08.07.24.
//

import SwiftUI

struct OnBoardingView: View {
    var totalPages = 2
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        if currentPage > totalPages {
            HomePageView()
        } else {
            if currentPage == 1 {
                OnBoardingReusablePage(
                    titleForOBPage: "მოგესალმებათ სია",
                    imageForOBPage: "StartingImage",
                    descriptionForOBPage: "აღმოაჩინეთ პროდუქტების ძიების უწყვეტი გზა, იპოვეთ საუკეთესო შეთავაზებები, შეადარეთ ფასები ერთმანეთს და შექმენით პერსონალური პროდუქტების სია მარტივად",
                    totalPages: totalPages,
                    currentPage: $currentPage,
                    isLastPage: false
                )
            }
            
            if currentPage == 2 {
                OnBoardingReusablePage(
                    titleForOBPage: "როგორ გამოვიყენოთ სია",
                    imageForOBPage: "როგორ გამოვიყენოთ სია",
                    descriptionForOBPage: "მოძებნე სასურველი პროდუქტი, გაფილტრე კატეგორიების ან მაღაზიების მიხედვით. იხილეთ ინფორმაცია თითოეული მაღაზიის შესახებ, მათ შორის მისამართები, გახსნის საათები და მიმდინარე შეთავაზებები. ",
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
