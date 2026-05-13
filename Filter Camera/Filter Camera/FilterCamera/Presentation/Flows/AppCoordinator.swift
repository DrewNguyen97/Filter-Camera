//
//  AppCoordinator.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import SwiftUI
import Combine

final class AppCoordinator: ObservableObject {
    @Published var currentRoute: AppRoute = .splash
    @Published var navigationPath: [AppRoute] = []

    func navigate(to route: AppRoute, _ isBack: Bool = false) {
        let animation: Animation = isBack ? .easeOut(duration: 0.3) : .easeInOut(duration: 0.3)
        withAnimation(animation) {
            currentRoute = route
        }
    }
    
    func navigateBack(to route: AppRoute) {
        withAnimation(.easeOut(duration: 0.3)) {
            currentRoute = route
        }
    }

    func navigateToOnboarding() {
        navigate(to: .onboarding)
    }
    
    func navigateToPaywall(_ isBack: Bool = false) {
        navigate(to: .paywall, isBack)
    }
    
    func navigateToCamera() {
        navigate(to: .camera)
    }
    
    func navigateToResult(videoURL: URL) {
        navigate(to: .result(videoURL))
    }
    
    func retryCamera() {
        navigateBack(to: .camera)
    }
}
