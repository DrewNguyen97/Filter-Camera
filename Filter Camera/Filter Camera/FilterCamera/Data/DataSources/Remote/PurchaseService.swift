import StoreKit

// MARK: - Purchase Error
enum PurchaseError: LocalizedError {
    case productNotFound
    case purchaseFailed
    case userCancelled
    case pending

    var errorDescription: String? {
        switch self {
        case .productNotFound: 
            return "Product not found."
        case .purchaseFailed: 
            return "Purchase failed. Please try again."
        case .userCancelled:   
            return "Purchase cancelled."
        case .pending:        
            return "Purchase is pending approval."
        }
    }
}

// MARK: - Purchase Service (StoreKit 2)
final class PurchaseService: PurchaseServiceProtocol {

    func purchase(productID: String) async throws -> Bool {
        guard let product = try await fetchProduct(id: productID) else {
            throw PurchaseError.productNotFound
        }

        let result = try await product.purchase()

        switch result {
        case .success(let verification):
            switch verification {
            case .verified(let transaction):
                await transaction.finish()
                return true
            case .unverified:
                throw PurchaseError.purchaseFailed
            }
        case .userCancelled:
            throw PurchaseError.userCancelled
        case .pending:
            throw PurchaseError.pending
        @unknown default:
            throw PurchaseError.purchaseFailed
        }
    }

    func restorePurchases() async throws -> Bool {
        try await AppStore.sync()
        for await result in Transaction.currentEntitlements {
            if case .verified(let transaction) = result {
                await transaction.finish()
                return true
            }
        }
        return false
    }

    func fetchProducts(ids: [String]) async throws -> [Product] {
        return try await Product.products(for: ids)
    }

    // MARK: - Private
    private func fetchProduct(id: String) async throws -> Product? {
        let products = try await fetchProducts(ids: [id])
        return products.first
    }
}
