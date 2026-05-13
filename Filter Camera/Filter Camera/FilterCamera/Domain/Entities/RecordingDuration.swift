//
//  RecordingDuration.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

enum RecordingDuration: Int, CaseIterable, Identifiable {
    case fifteen  = 15
    case thirty   = 30
    case sixty    = 60
    case onetwenty = 120

    var id: Int { rawValue }

    var displayText: String {
        switch self {
        case .fifteen:  
            return "15s"
        case .thirty:   
            return "30s"
        case .sixty:    
            return "60s"
        case .onetwenty: 
            return "120s"
        }
    }
}
