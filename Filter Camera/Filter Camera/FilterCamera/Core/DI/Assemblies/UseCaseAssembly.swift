import Foundation
import Swinject

final class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CheckOnboardingSeenUseCaseProtocol.self) { r in
            CheckOnboardingSeenUseCase(repository: r.resolveSafe(OnboardingRepositoryProtocol.self))
        }

        container.register(MarkOnboardingSeenUseCaseProtocol.self) { r in
            MarkOnboardingSeenUseCase(repository: r.resolveSafe(OnboardingRepositoryProtocol.self))
        }

        container.register(CheckPremiumUseCaseProtocol.self) { r in
            CheckPremiumUseCase(repository: r.resolveSafe(PurchaseRepositoryProtocol.self))
        }

        container.register(PurchaseProductUseCaseProtocol.self) { r in
            PurchaseProductUseCase(repository: r.resolveSafe(PurchaseRepositoryProtocol.self))
        }

        container.register(RestorePurchaseUseCaseProtocol.self) { r in
            RestorePurchaseUseCase(repository: r.resolveSafe(PurchaseRepositoryProtocol.self))
        }

        container.register(FetchProductsUseCaseProtocol.self) { r in
            FetchProductsUseCase(repository: r.resolveSafe(PurchaseRepositoryProtocol.self))
        }

        container.register(SaveVideoUseCaseProtocol.self) { r in
            SaveVideoUseCase(repository: r.resolveSafe(VideoRepositoryProtocol.self))
        }
    }
}
