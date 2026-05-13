//
//  AppLayout.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import SwiftUI

enum AppSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
}

enum AppCornerRadius {
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 20
    static let xl: CGFloat = 24
    static let pill: CGFloat = 26
}

enum AppShadow {
    static let primary = Color("primary").opacity(0.3)
    static let orange = Color("accent").opacity(0.35)
    static let card = Color.black.opacity(0.08)
}
