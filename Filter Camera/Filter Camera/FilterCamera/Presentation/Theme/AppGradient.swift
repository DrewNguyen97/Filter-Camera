//
//  AppGradient.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import SwiftUI

enum AppGradient {
    // Splash & Onboarding — purple gradient from Figma
    static let splashBackground = LinearGradient(
        colors: [Color(hex: "#8B2FC9"), Color(hex: "#C850C0"), Color(hex: "#DA44BB")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let onboardingBackground = LinearGradient(
        colors: [Color(hex: "#7B2FBE"), Color(hex: "#C850C0")],
        startPoint: .top, endPoint: .bottom
    )

    // Loading Progress
    static let loadingProgress = LinearGradient(
        colors: [Color("primary"), Color("primaryLight")],
        startPoint: .leading, endPoint: .trailing
    )

    // CTA / Record button — orange from Figma
    static let recordButton = LinearGradient(
        colors: [Color(hex: "#FF6B35"), Color(hex: "#FF9A3C")],
        startPoint: .leading, endPoint: .trailing
    )
    static let ctaButton = LinearGradient(
        colors: [Color(hex: "#FF6B35"), Color(hex: "#FF9A3C")],
        startPoint: .leading, endPoint: .trailing
    )

    // Paywall
    static let paywallCard = LinearGradient(
        colors: [Color(hex: "#F0E8FF"), Color(hex: "#E8D5FF")],
        startPoint: .top, endPoint: .bottom
    )
    static let popularBadge = LinearGradient(
        colors: [Color("primary"), Color("primaryLight")],
        startPoint: .leading, endPoint: .trailing
    )
    static let selectedPlan = LinearGradient(
        colors: [Color(hex: "#8B2FC9").opacity(0.12), Color(hex: "#C850C0").opacity(0.08)],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
}
