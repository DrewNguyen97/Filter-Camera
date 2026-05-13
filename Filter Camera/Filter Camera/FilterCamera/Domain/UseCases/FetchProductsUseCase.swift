//
//  FetchProductsUseCase.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation
import StoreKit

protocol FetchProductsUseCaseProtocol {
    func execute(ids: [String]) async throws -> [Product]
}

final class FetchProductsUseCase: FetchProductsUseCaseProtocol {
    private let repository: PurchaseRepositoryProtocol

    init(repository: PurchaseRepositoryProtocol) {
        self.repository = repository
    }

    func execute(ids: [String]) async throws -> [Product] {
        try await repository.fetchProducts(ids: ids)
    }
}
