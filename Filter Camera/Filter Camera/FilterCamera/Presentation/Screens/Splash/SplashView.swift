//
//  SplashView.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import SwiftUI

// MARK: - Splash View
struct SplashView: View {
    @StateObject var viewModel: SplashViewModel
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        ZStack {
            AppColor.splashBackgroundSolid.ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer()
                
                Image(AppImage.splash)

                Spacer()

                VStack(spacing: AppSpacing.md) {
                    Image(AppImage.watermark)
                    // Loading text + progress bar
                    VStack(spacing: AppSpacing.sm) {
                        Text(AppText.loading)
                            .font(AppTypography.extraText)
                            .lineSpacing(4.8)
                            .multilineTextAlignment(.center)
                            .foregroundColor(AppColor.loadingText)

                        // Progress bar
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(AppColor.progressBackground)
                                    .frame(height: 5)
                                Capsule()
                                    .fill(AppGradient.loadingProgress)
                                    .frame(width: geo.size.width * viewModel.loadingProgress, height: 5)
                                    .animation(.easeInOut(duration: 0.3), value: viewModel.loadingProgress)
                            }
                        }
                        .frame(height: 5)
                        .padding(.horizontal, AppSpacing.xl)
                        .cornerRadius(AppCornerRadius.sm)
                    }
                }
                .padding(.bottom, 56)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onChange(of: viewModel.destination) { destination in
            guard let dest = destination else { return }
            switch dest {
            case .onboarding:
                coordinator.navigateToOnboarding()
            case .paywall:
                coordinator.navigateToPaywall()
            case .camera:
                coordinator.navigateToCamera()
            }
        }
    }
}
