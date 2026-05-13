//
//  PurchaseRepository.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation
import StoreKit

final class PurchaseRepository: PurchaseRepositoryProtocol {
    private let purchaseService: PurchaseServiceProtocol
    private let localDataSource: PurchaseLocalDataSource

    init(purchaseService: PurchaseServiceProtocol, localDataSource: PurchaseLocalDataSource) {
        self.purchaseService = purchaseService
        self.localDataSource = localDataSource
    }

    func isPremium() -> Bool { localDataSource.isPremium() }
    func savePremiumStatus(_ isPremium: Bool) { localDataSource.savePremiumStatus(isPremium) }

    func purchase(productID: String) async throws -> Bool {
        try await purchaseService.purchase(productID: productID)
    }

    func restorePurchases() async throws -> Bool {
        try await purchaseService.restorePurchases()
    }

    func fetchProducts(ids: [String]) async throws -> [Product] {
        try await purchaseService.fetchProducts(ids: ids)
    }
}
