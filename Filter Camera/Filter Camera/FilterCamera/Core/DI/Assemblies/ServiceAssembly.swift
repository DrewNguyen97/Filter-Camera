import Foundation
import Swinject

final class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(UserDefaultsServiceProtocol.self) { _ in UserDefaultsService() }.inObjectScope(.container)
        container.register(CameraServiceProtocol.self) { _ in CameraService() }.inObjectScope(.container)
        container.register(PhotoLibraryServiceProtocol.self) { _ in PhotoLibraryService() }.inObjectScope(.container)
        container.register(PurchaseServiceProtocol.self) { _ in PurchaseService() }.inObjectScope(.container)
    }
}
