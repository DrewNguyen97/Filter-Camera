//
//  AppRoute.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

enum AppRoute: Hashable {
    case splash
    case onboarding
    case paywall
    case camera
    case result(URL)

    func hash(into hasher: inout Hasher) {
        switch self {
        case .splash:
            hasher.combine(0)
        case .onboarding:
            hasher.combine(1)
        case .paywall:
            hasher.combine(2)
        case .camera:
            hasher.combine(3)
        case .result(let url):
            hasher.combine(4)
            hasher.combine(url)
        }
    }

    static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
        switch (lhs, rhs) {
        case (.splash, .splash), (.onboarding, .onboarding),
             (.paywall, .paywall), (.camera, .camera):
            return true
        case (.result(let a), .result(let b)):
            return a == b
        default:
            return false
        }
    }
}
