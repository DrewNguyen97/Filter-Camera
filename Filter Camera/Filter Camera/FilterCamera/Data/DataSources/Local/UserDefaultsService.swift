import Foundation

// MARK: - UserDefaults Keys
enum UserDefaultsKey {
    static let hasSeenOnboarding = "hasSeenOnboarding"
    static let isPremium = "isPremium"
    static let selectedPlanID = "selectedPlanID"
}

final class UserDefaultsService: UserDefaultsServiceProtocol {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func bool(forKey key: String) -> Bool { defaults.bool(forKey: key) }
    func set(_ value: Bool, forKey key: String) { defaults.set(value, forKey: key) }
    func string(forKey key: String) -> String? { defaults.string(forKey: key) }
    func set(_ value: String, forKey key: String) { defaults.set(value, forKey: key) }
}

