//
//  PremiumFeature.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

// MARK: - Premium Feature Model
struct PremiumFeature: Identifiable {
    let id = UUID()
    let icon: String
    let title: String

    static let all: [PremiumFeature] = [
        .init(icon: "nosign",                  title: "Remove ads"),
        .init(icon: "wand.and.stars",          title: "Record with random filters"),
        .init(icon: "sparkles",                title: "Unlock all trending filters"),
        .init(icon: "infinity",                title: "Record without use limit"),
        .init(icon: "star.fill",               title: "Unlock all features")
    ]
}
