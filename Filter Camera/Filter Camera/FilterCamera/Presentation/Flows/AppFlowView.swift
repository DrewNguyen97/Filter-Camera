//
//  AppFlowView.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import SwiftUI
import Combine

import SwiftUI
import Combine

// MARK: - App Flow View
struct AppFlowView: View {
    @EnvironmentObject var diContainer: AppDIContainer
    @StateObject private var coordinator = AppCoordinator()

    var body: some View {
        ZStack {
            AppColor.background.ignoresSafeArea()

            switch coordinator.currentRoute {
            case .splash:
                SplashView(viewModel: diContainer.makeSplashViewModel())
                    .environmentObject(coordinator)
                    .transition(.opacity)

            case .onboarding:
                OnboardingView(viewModel: diContainer.makeOnboardingViewModel())
                    .environmentObject(coordinator)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))

            case .paywall:
                PaywallView(viewModel: diContainer.makePaywallViewModel())
                    .environmentObject(coordinator)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))

            case .camera:
                CameraView(viewModel: diContainer.makeCameraViewModel())
                    .environmentObject(coordinator)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))

            case .result(let url):
                ResultView(viewModel: diContainer.makeResultViewModel(videoURL: url))
                    .environmentObject(coordinator)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))
            }
        }
        .animation(.easeInOut(duration: 0.35), value: coordinator.currentRoute)
    }
}
