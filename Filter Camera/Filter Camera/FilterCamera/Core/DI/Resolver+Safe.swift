import Foundation
import Swinject

extension Resolver {
    /// Resolves a dependency safely and throws a clear fatalError if not found.
    /// This avoids using force-unwraps (!) directly and provides better debug information.
    func resolveSafe<Service>(_ serviceType: Service.Type) -> Service {
        guard let dependency = resolve(serviceType) else {
            fatalError("💥 Swinject: Could not resolve dependency for \(String(describing: serviceType)). Did you forget to register it in an Assembly?")
        }
        return dependency
    }
    
    /// Resolves a dependency safely with arguments.
    func resolveSafe<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service {
        guard let dependency = resolve(serviceType, argument: argument) else {
            fatalError("💥 Swinject: Could not resolve dependency for \(String(describing: serviceType)) with argument \(String(describing: Arg1.self)).")
        }
        return dependency
    }
}
