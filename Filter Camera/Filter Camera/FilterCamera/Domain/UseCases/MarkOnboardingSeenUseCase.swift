//
//  MarkOnboardingSeenUseCase.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

protocol MarkOnboardingSeenUseCaseProtocol {
    func execute()
}

final class MarkOnboardingSeenUseCase: MarkOnboardingSeenUseCaseProtocol {
    private let repository: OnboardingRepositoryProtocol
    
    init(repository: OnboardingRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() {
        repository.markOnboardingSeen()
    }
}
