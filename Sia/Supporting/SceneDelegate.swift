//
//  SceneDelegate.swift
//  Sia
//
//  Created by Sandro Gelashvili on 03.07.24.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let onboardingView = OnBoardingView()
        let hostingController = UIHostingController(rootView: onboardingView)
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = hostingController
        window?.makeKeyAndVisible()
    }
}
