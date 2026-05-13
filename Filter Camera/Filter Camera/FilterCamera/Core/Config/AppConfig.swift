//
//  AppConfig.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 12/5/26.
//

import Foundation

enum AppConfig {
    static let appName = "Filter Camera"
    
    // Ads Configuration
    enum Ads {
        #if DEBUG
        // Test ad unit IDs
        static let nativeOnboarding = "ca-app-pub-3940256099942544/3986624511"
        static let nativeCamera     = "ca-app-pub-3940256099942544/3986624511"
        static let nativeResult     = "ca-app-pub-3940256099942544/3986624511"
        static let interstitialSplash = "ca-app-pub-3940256099942544/4411468910"
        static let interstitialResult = "ca-app-pub-3940256099942544/4411468910"
        #else
        // Real ad unit IDs
        static let nativeOnboarding = "ca-app-pub-3940256069442306/XXXXXXXXXX"
        static let nativeCamera     = "ca-app-pub-3940256069442306/XXXXXXXXXX"
        static let nativeResult     = "ca-app-pub-3940256069442306/XXXXXXXXXX"
        static let interstitialSplash = "ca-app-pub-3940256069442306/XXXXXXXXXX"
        static let interstitialResult = "ca-app-pub-3940256069442306/XXXXXXXXXX"
        #endif
    }
    
    // Subscription Configuration
    enum Subscription {
        static let weeklyID = "filtercamera.premium.weekly"
        static let monthlyID = "filtercamera.premium.monthly"
        static let yearlyID = "filtercamera.premium.yearly"
    }
}

// Global accessor for convenience
enum AdUnitID {
    static let nativeOnboarding = AppConfig.Ads.nativeOnboarding
    static let nativeCamera     = AppConfig.Ads.nativeCamera
    static let nativeResult     = AppConfig.Ads.nativeResult
    static let interstitialSplash = AppConfig.Ads.interstitialSplash
    static let interstitialResult = AppConfig.Ads.interstitialResult
    
    static var applicationIdentifier: String {
        return Bundle.main.object(forInfoDictionaryKey: "GADApplicationIdentifier") as? String ?? ""
    }
}
