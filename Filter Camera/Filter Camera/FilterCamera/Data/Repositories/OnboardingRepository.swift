//
//  OnboardingRepository.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

final class OnboardingRepository: OnboardingRepositoryProtocol {
    private let localDataSource: OnboardingLocalDataSource

    init(localDataSource: OnboardingLocalDataSource) {
        self.localDataSource = localDataSource
    }

    func hasSeenOnboarding() -> Bool {
        localDataSource.hasSeenOnboarding()
    }
    
    func markOnboardingSeen() {
        localDataSource.markOnboardingSeen()
    }
}
