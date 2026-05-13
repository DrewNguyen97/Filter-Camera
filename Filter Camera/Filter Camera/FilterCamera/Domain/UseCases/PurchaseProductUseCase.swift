//
//  PurchaseProductUseCase.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

protocol PurchaseProductUseCaseProtocol {
    func execute(productID: String) async throws -> Bool
}

final class PurchaseProductUseCase: PurchaseProductUseCaseProtocol {
    private let repository: PurchaseRepositoryProtocol
    
    init(repository: PurchaseRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(productID: String) async throws -> Bool {
        let success = try await repository.purchase(productID: productID)
        if success { repository.savePremiumStatus(true) }
        return success
    }
}
