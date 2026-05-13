//
//  VideoRepositoryProtocol.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 12/5/26.
//

import Foundation

protocol VideoRepositoryProtocol {
    func saveToPhotoLibrary(videoURL: URL) async throws
}
