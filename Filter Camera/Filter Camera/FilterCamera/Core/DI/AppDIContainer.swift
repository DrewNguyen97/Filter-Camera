import Foundation
import Combine
import Swinject

// MARK: - App DI Container (Root Composition Root)
final class AppDIContainer: ObservableObject {
    
    private let assembler: Assembler
    
    private var container: Resolver {
        return assembler.resolver
    }

    init() {
        self.assembler = Assembler([
            ServiceAssembly(),
            RepositoryAssembly(),
            UseCaseAssembly(),
            ViewModelAssembly()
        ])
    }

    // MARK: - ViewModel Factories
    func makeSplashViewModel() -> SplashViewModel {
        container.resolveSafe(SplashViewModel.self)
    }

    func makeOnboardingViewModel() -> OnboardingViewModel {
        container.resolveSafe(OnboardingViewModel.self)
    }

    func makePaywallViewModel() -> PaywallViewModel {
        container.resolveSafe(PaywallViewModel.self)
    }

    func makeCameraViewModel() -> CameraViewModel {
        container.resolveSafe(CameraViewModel.self)
    }

    func makeResultViewModel(videoURL: URL) -> ResultViewModel {
        container.resolveSafe(ResultViewModel.self, argument: videoURL)
    }
}
