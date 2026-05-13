//
//  SubscriptionPlan.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

struct SubscriptionPlan: Identifiable, Codable {
    let id: String
    let name: String
    let price: String
    let period: String
    let subtext: String?
    let isBestOffer: Bool
}

extension SubscriptionPlan {
    static var all: [SubscriptionPlan] {
        if let url = Bundle.main.url(forResource: "SubscriptionConfig", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let plans = try? JSONDecoder().decode([SubscriptionPlan].self, from: data) {
            return plans
        }
        print("⚠️ Warning: Could not load SubscriptionConfig.json or parse its contents.")
        return []
    }
    
    func with(price: String) -> SubscriptionPlan {
        SubscriptionPlan(id: id, name: name, price: price,
                         period: period, subtext: subtext, isBestOffer: isBestOffer)
    }
}

// MARK: - SubscriptionPlan Helpers
extension Array where Element == SubscriptionPlan {
    var bestOfferOrFirst: SubscriptionPlan {
        first(where: { $0.isBestOffer })
        ?? first
        ?? SubscriptionPlan(id: "", name: "", price: "", period: "", subtext: nil, isBestOffer: false)
    }
}
