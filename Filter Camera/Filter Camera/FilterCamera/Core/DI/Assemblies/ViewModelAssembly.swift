import Foundation
import Swinject

final class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SplashViewModel.self) { r in
            SplashViewModel(
                checkOnboardingSeenUseCase: r.resolveSafe(CheckOnboardingSeenUseCaseProtocol.self),
                checkPremiumUseCase: r.resolveSafe(CheckPremiumUseCaseProtocol.self)
            )
        }

        container.register(OnboardingViewModel.self) { r in
            OnboardingViewModel(markOnboardingSeenUseCase: r.resolveSafe(MarkOnboardingSeenUseCaseProtocol.self))
        }

        container.register(PaywallViewModel.self) { r in
            PaywallViewModel(
                purchaseProductUseCase: r.resolveSafe(PurchaseProductUseCaseProtocol.self),
                restorePurchaseUseCase: r.resolveSafe(RestorePurchaseUseCaseProtocol.self),
                checkPremiumUseCase: r.resolveSafe(CheckPremiumUseCaseProtocol.self),
                fetchProductsUseCase: r.resolveSafe(FetchProductsUseCaseProtocol.self)
            )
        }

        container.register(CameraViewModel.self) { r in
            CameraViewModel(
                cameraService: r.resolveSafe(CameraServiceProtocol.self),
                checkPremiumUseCase: r.resolveSafe(CheckPremiumUseCaseProtocol.self)
            )
        }

        container.register(ResultViewModel.self) { (r, videoURL: URL) in
            ResultViewModel(
                videoURL: videoURL,
                saveVideoUseCase: r.resolveSafe(SaveVideoUseCaseProtocol.self)
            )
        }
    }
}
