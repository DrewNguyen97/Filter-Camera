import Foundation

// MARK: - Onboarding Local Data Source
final class OnboardingLocalDataSource {
    private let userDefaultsService: UserDefaultsServiceProtocol

    init(userDefaultsService: UserDefaultsServiceProtocol) {
        self.userDefaultsService = userDefaultsService
    }

    func hasSeenOnboarding() -> Bool {
        userDefaultsService.bool(forKey: UserDefaultsKey.hasSeenOnboarding)
    }

    func markOnboardingSeen() {
        userDefaultsService.set(true, forKey: UserDefaultsKey.hasSeenOnboarding)
    }
}

// MARK: - Purchase Local Data Source
final class PurchaseLocalDataSource {
    private let userDefaultsService: UserDefaultsServiceProtocol

    init(userDefaultsService: UserDefaultsServiceProtocol) {
        self.userDefaultsService = userDefaultsService
    }

    func isPremium() -> Bool {
        userDefaultsService.bool(forKey: UserDefaultsKey.isPremium)
    }

    func savePremiumStatus(_ value: Bool) {
        userDefaultsService.set(value, forKey: UserDefaultsKey.isPremium)
    }
}
