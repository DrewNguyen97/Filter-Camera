//
//  CameraFilter.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

struct CameraFilter: Identifiable {
    let id: String
    let name: String
    let resourceURL: URL?
    let intensity: Float

    static func random(from filters: [CameraFilter]) -> CameraFilter? {
        filters.randomElement()
    }
}
