//
//  AppDelegate.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import SwiftUI
import GoogleMobileAds

// MARK: - App Delegate for Google Mobile Ads SDK Initialization
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // Initialize Google Mobile Ads SDK
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }
}
