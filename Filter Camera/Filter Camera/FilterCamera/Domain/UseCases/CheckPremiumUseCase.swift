//
//  CheckPremiumUseCase.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

protocol CheckPremiumUseCaseProtocol {
    func execute() -> Bool
}

final class CheckPremiumUseCase: CheckPremiumUseCaseProtocol {
    private let repository: PurchaseRepositoryProtocol
    
    init(repository: PurchaseRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> Bool {
        repository.isPremium()
    }
}
