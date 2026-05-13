//
//  NativeAdManager.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation
import GoogleMobileAds
import Combine

// MARK: - Native Ad Manager
/// Handles loading, caching, and providing native ads to SwiftUI views.
final class NativeAdManager: NSObject, ObservableObject {
    @Published var nativeAd: GADNativeAd?
    @Published var isLoading = false
    @Published var loadFailed = false

    private var adLoader: GADAdLoader?
    private let adUnitID: String

    init(adUnitID: String) {
        self.adUnitID = adUnitID
        super.init()
    }

    func loadAd() {
        guard !isLoading else { return }
        isLoading = true
        loadFailed = false

        let adLoader = GADAdLoader(
            adUnitID: adUnitID,
            rootViewController: nil,
            adTypes: [.native],
            options: nil
        )
        adLoader.delegate = self
        self.adLoader = adLoader
        adLoader.load(GADRequest())
    }
}

// MARK: - GADNativeAdLoaderDelegate
extension NativeAdManager: GADNativeAdLoaderDelegate {
    func adLoader(_ adLoader: GADAdLoader, didReceive nativeAd: GADNativeAd) {
        DispatchQueue.main.async { [weak self] in
            self?.nativeAd = nativeAd
            self?.isLoading = false
            self?.loadFailed = false
        }
    }

    func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.isLoading = false
            self?.loadFailed = true
            print("⚠️ AdMob native ad failed to load: \(error.localizedDescription)")
        }
    }
}
