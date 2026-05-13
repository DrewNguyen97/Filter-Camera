//
//  FilterCameraApp.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import SwiftUI

@main
struct FilterCameraApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appDIContainer = AppDIContainer()

    var body: some Scene {
        WindowGroup {
            AppFlowView()
                .environmentObject(appDIContainer)
                .preferredColorScheme(.dark)
        }
    }
}
