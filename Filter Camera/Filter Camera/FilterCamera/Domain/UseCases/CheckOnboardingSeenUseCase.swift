//
//  CheckOnboardingSeenUseCase.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

protocol CheckOnboardingSeenUseCaseProtocol {
    func execute() -> Bool
}

final class CheckOnboardingSeenUseCase: CheckOnboardingSeenUseCaseProtocol {
    private let repository: OnboardingRepositoryProtocol
    
    init(repository: OnboardingRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> Bool {
        repository.hasSeenOnboarding()
    }
}
