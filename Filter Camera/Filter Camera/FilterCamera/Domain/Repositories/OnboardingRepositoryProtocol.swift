//
//  OnboardingRepositoryProtocol.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

protocol OnboardingRepositoryProtocol {
    func hasSeenOnboarding() -> Bool
    func markOnboardingSeen()
}
