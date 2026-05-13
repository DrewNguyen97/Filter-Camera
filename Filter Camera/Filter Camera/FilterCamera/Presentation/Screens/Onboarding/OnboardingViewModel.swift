//
//  OnboardingViewModel.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import SwiftUI
import Combine

// MARK: - Onboarding ViewModel
final class OnboardingViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    @Published var shouldNavigateToPaywall = false

    let pages: [OnboardingPage] = [
        OnboardingPage(
            id: 0,
            title: AppText.firstOnboardingTitle,
            imageName: AppImage.onboarding1
        ),
        OnboardingPage(
            id: 1,
            title: AppText.secondOnboardingTitle,
            imageName: AppImage.onboarding2
        ),
        OnboardingPage(
            id: 2,
            title: AppText.thirdOnboardingTitle,
            imageName: AppImage.onboarding3
        )
    ]

    var isLastPage: Bool {
        currentPage == pages.count - 1
    }

    private let markOnboardingSeenUseCase: MarkOnboardingSeenUseCaseProtocol

    init(markOnboardingSeenUseCase: MarkOnboardingSeenUseCaseProtocol) {
        self.markOnboardingSeenUseCase = markOnboardingSeenUseCase
    }

    func nextPage() {
        if isLastPage {
            finishOnboarding()
        } else {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                currentPage += 1
            }
        }
    }

    func skip() {
        finishOnboarding()
    }

    func setPage(_ page: Int) {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            currentPage = page
        }
    }

    private func finishOnboarding() {
        markOnboardingSeenUseCase.execute()
        shouldNavigateToPaywall = true
    }
}
