import Foundation
import Swinject

final class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(OnboardingRepositoryProtocol.self) { r in
            let localDataSource = OnboardingLocalDataSource(userDefaultsService: r.resolveSafe(UserDefaultsServiceProtocol.self))
            return OnboardingRepository(localDataSource: localDataSource)
        }.inObjectScope(.container)

        container.register(PurchaseRepositoryProtocol.self) { r in
            let localDataSource = PurchaseLocalDataSource(userDefaultsService: r.resolveSafe(UserDefaultsServiceProtocol.self))
            return PurchaseRepository(
                purchaseService: r.resolveSafe(PurchaseServiceProtocol.self),
                localDataSource: localDataSource
            )
        }.inObjectScope(.container)

        container.register(VideoRepositoryProtocol.self) { r in
            VideoRepository(photoLibraryService: r.resolveSafe(PhotoLibraryServiceProtocol.self))
        }.inObjectScope(.container)
    }
}
