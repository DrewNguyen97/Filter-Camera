//
//  RestorePurchaseUseCase.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

protocol RestorePurchaseUseCaseProtocol {
    func execute() async throws -> Bool
}

final class RestorePurchaseUseCase: RestorePurchaseUseCaseProtocol {
    private let repository: PurchaseRepositoryProtocol
    
    init(repository: PurchaseRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> Bool {
        let success = try await repository.restorePurchases()
        if success { repository.savePremiumStatus(true) }
        return success
    }
}
