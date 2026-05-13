//
//  AppColor.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import SwiftUI

enum AppColor {
    // Backgrounds
    static let background = Color.white
    static let backgroundDark = Color("backgroundDark")
    static let surface = Color("surface")
    static let surfaceElevated = Color.white
    static let splashBackgroundSolid = Color("cl_primary300")
    static let resultBackground = Color(hex: "#FAE7F9")  // hồng nhạt

    // Brand
    static let primary = Color("cl_primary")
    static let primaryLight = Color("cl_primaryLight")
    static let primaryGlow = Color("cl_primary").opacity(0.2)
    static let accent = Color("accent")

    // Text
    static let textPrimary = Color("textPrimary")
    static let textSecondary = Color("textSecondary")
    static let textTertiary = Color("textTertiary")
    static let textOnPurple = Color.white
    static let loadingText = Color("cl_text2")
    static let text1 = Color("cl_text1")
    static let ghostText = Color("cl_ghostText")

    // Status
    static let success = Color("success")
    static let warning = Color("warning")
    static let error = Color("error")

    // UI elements
    static let divider = Color("divider")
    static let cardBorder = Color("cl_cardBorder")
    static let cardBackground = Color("cl_cardBackground")
    static let selectedBorder = Color("cl_selectedBorder")
    static let selectedBackground = Color("cl_selectedBackground")
    static let buttonContinue = Color("cl_buttonContinue")
    static let buttonContinueBorder = Color("cl_buttonContinueBorder")
    
    // Overlays & Specials
    static let cameraOverlay   = Color.black.opacity(0.3)
    static let cameraControlBg = Color.white.opacity(0.3)
    static let resultVideoBg   = Color("cl_resultVideoBg")
    static let progressBackground = Color("cl_progressBackground").opacity(0.25)
}
