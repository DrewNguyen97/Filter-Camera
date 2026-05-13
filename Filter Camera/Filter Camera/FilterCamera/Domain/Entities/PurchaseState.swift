//
//  PurchaseState.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

enum PurchaseState: Equatable {
    case idle
    case loading
    case purchased
    case failed(Error)
    case restored
    
    static func == (lhs: PurchaseState, rhs: PurchaseState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.loading, .loading), (.purchased, .purchased), (.restored, .restored):
            return true
        default:
            return false
        }
    }
}
