//
//  PaywallViewModel.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 8/5/26.
//

import SwiftUI
import Combine
import StoreKit

// MARK: - Paywall ViewModel
@MainActor
final class PaywallViewModel: ObservableObject {

    // MARK: - Published
    @Published var selectedPlan: SubscriptionPlan
    @Published var purchaseState: PurchaseState = .idle
    @Published var showCloseButton = false
    @Published var shouldNavigateToCamera = false
    @Published var errorMessage: String?
    @Published var isShowingError = false
    @Published var plans: [SubscriptionPlan]

    // MARK: - Dependencies
    private let purchaseProductUseCase: PurchaseProductUseCaseProtocol
    private let restorePurchaseUseCase: RestorePurchaseUseCaseProtocol
    private let checkPremiumUseCase: CheckPremiumUseCaseProtocol
    private let fetchProductsUseCase: FetchProductsUseCaseProtocol

    // MARK: - Init
    init(
        purchaseProductUseCase: PurchaseProductUseCaseProtocol,
        restorePurchaseUseCase: RestorePurchaseUseCaseProtocol,
        checkPremiumUseCase: CheckPremiumUseCaseProtocol,
        fetchProductsUseCase: FetchProductsUseCaseProtocol
    ) {
        self.purchaseProductUseCase = purchaseProductUseCase
        self.restorePurchaseUseCase = restorePurchaseUseCase
        self.checkPremiumUseCase = checkPremiumUseCase
        self.fetchProductsUseCase = fetchProductsUseCase

        let initialPlans = SubscriptionPlan.all
        self.plans = initialPlans
        self.selectedPlan = initialPlans.bestOfferOrFirst
    }

    // MARK: - Lifecycle
    func onAppear() {
        Task {
            await fetchRealPrices()
        }
        Task {
            await scheduleCloseButton()
        }
    }

    // MARK: - Actions
    func purchase() {
        guard case .idle = purchaseState else { return }
        Task {
            await performPurchase()
        }
    }
    
    func showPolicy() {
        //TODO: Show policy
    }
    
    func restore() {
        guard case .idle = purchaseState else { return }
        Task {
            await performRestore()
        }
    }

    func showTerm() {
        //TODO: Show term
    }

    func close() {
        shouldNavigateToCamera = true
    }

    func clearError() {
        errorMessage = nil
        isShowingError = false
    }
}

// MARK: - Private
private extension PaywallViewModel {

    func scheduleCloseButton() async {
        try? await Task.sleep(for: .seconds(5))
        withAnimation(.easeIn(duration: 0.3)) {
            showCloseButton = true
        }
    }

    func fetchRealPrices() async {
        let productIDs = plans.map { $0.id }
        do {
            let products = try await fetchProductsUseCase.execute(ids: productIDs)
            let updatedPlans = plans.map { plan -> SubscriptionPlan in
                guard let product = products.first(where: { $0.id == plan.id }) else { return plan }
                return plan.with(price: product.displayPrice)
            }
            withAnimation {
                plans = updatedPlans
                if let refreshed = updatedPlans.first(where: { $0.id == selectedPlan.id }) {
                    selectedPlan = refreshed
                }
            }
        } catch {
            print("Failed to fetch real prices: \(error)")
        }
    }

    func performPurchase() async {
        purchaseState = .loading
        do {
            let success = try await purchaseProductUseCase.execute(productID: selectedPlan.id)
            purchaseState = success ? .purchased : .idle
            if success {
                shouldNavigateToCamera = true
            }
        } catch {
            handleError(error)
        }
    }

    func performRestore() async {
        purchaseState = .loading
        do {
            let success = try await restorePurchaseUseCase.execute()
            purchaseState = success ? .restored : .idle
            if success {
                shouldNavigateToCamera = true
            }
        } catch {
            handleError(error)
        }
    }

    func handleError(_ error: Error) {
        purchaseState = .idle
        errorMessage = error.localizedDescription
        isShowingError = true
    }
}
