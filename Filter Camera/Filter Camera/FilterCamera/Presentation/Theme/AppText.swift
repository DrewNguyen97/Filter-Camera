//
//  AppText.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import SwiftUI

enum AppText {
    private static func localized(_ key: String) -> String {
        return NSLocalizedString(key, bundle: Bundle.main, comment: "")
    }
    // Splash
    static let loading = localized("splash_loading")
    
    // Onboarding
    static let next = localized("onboarding_next")
    static let firstOnboardingTitle = localized("onboarding_title_1")
    static let secondOnboardingTitle = localized("onboarding_title_2")
    static let thirdOnboardingTitle = localized("onboarding_title_3")
    
    // Paywall
    static let continueAction = localized("paywall_continue")
    static let randomFilterPremium = localized("paywall_random_filter_premium")
    static let premiumBenefits = localized("paywall_premium_benefits")
    static let free = localized("paywall_free")
    static let premium = localized("paywall_premium")
    static let bestOffer = localized("paywall_best_offer")
    static let privacyPolicy = localized("paywall_privacy_policy")
    static let restore = localized("paywall_restore")
    static let terms = localized("paywall_terms")
    
    // Camera
    static let addMusic = localized("camera_add_music")
    static let unlockAll = localized("camera_unlock_all")
    static let filter = localized("camera_filter")
    
    // Result
    static let result = localized("result_title")
    static let savedToPhotos = localized("result_saved_to_photos")
    static let retry = localized("result_retry")
    static let save = localized("result_save")
    static let share = localized("result_share")
    static let error = localized("common_error")
    static let ok = localized("common_ok")
}
