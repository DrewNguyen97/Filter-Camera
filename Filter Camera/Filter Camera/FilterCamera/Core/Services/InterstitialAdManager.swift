//
//  InterstitialAdManager.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation
import GoogleMobileAds
import Combine

// MARK: - Interstitial Ad Manager
@MainActor
final class InterstitialAdManager: NSObject, ObservableObject {
    static let shared = InterstitialAdManager()

    private var interstitialAd: GADInterstitialAd?
    @Published var isLoaded = false
    @Published var hasCompletedLoadAttempt = false
    
    private var dismissalContinuation: CheckedContinuation<Void, Never>?

    private override init() {
        super.init()
    }

    func loadAd(adUnitID: String) async {
        hasCompletedLoadAttempt = false
        isLoaded = false
        
        return await withCheckedContinuation { continuation in
            let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID: adUnitID, request: request) { [weak self] ad, error in
                guard let self else {
                    continuation.resume()
                    return
                }

                Task { @MainActor [self] in
                    if let error = error {
                        print("⚠️ Failed to load interstitial ad: \(error.localizedDescription)")
                        self.isLoaded = false
                        self.hasCompletedLoadAttempt = true
                        continuation.resume()
                        return
                    }
                    
                    self.interstitialAd = ad
                    self.interstitialAd?.fullScreenContentDelegate = self
                    self.isLoaded = true
                    self.hasCompletedLoadAttempt = true
                    continuation.resume()
                }
            }
        }
    }

    func presentAd() async {
        guard let ad = interstitialAd else {
            print("⚠️ Ad wasn't ready")
            return
        }
        
        guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
              let rootViewController = windowScene.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            print("⚠️ Could not find root view controller")
            return
        }
    
        return await withCheckedContinuation { continuation in
            self.dismissalContinuation = continuation
            ad.present(fromRootViewController: rootViewController)
        }
    }
}

// MARK: - GADFullScreenContentDelegate
extension InterstitialAdManager: GADFullScreenContentDelegate {
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("⚠️ Ad did fail to present full screen content.")
        isLoaded = false
        dismissalContinuation?.resume()
        dismissalContinuation = nil
    }

    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        isLoaded = false
        dismissalContinuation?.resume()
        dismissalContinuation = nil
    }
}
