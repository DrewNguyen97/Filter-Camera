//
//  RecordingState.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

enum RecordingState {
    case idle
    case countdown(Int)
    case recording(elapsed: TimeInterval, total: TimeInterval)
    case finished(URL)
    case failed(Error)
}
