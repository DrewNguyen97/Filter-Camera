//
//  PurchaseRepositoryProtocol.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import StoreKit

protocol PurchaseRepositoryProtocol {
    func isPremium() -> Bool
    func purchase(productID: String) async throws -> Bool
    func restorePurchases() async throws -> Bool
    func savePremiumStatus(_ isPremium: Bool)
    func fetchProducts(ids: [String]) async throws -> [Product]
}
