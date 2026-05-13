//
//  SaveVideoUseCase.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 12/5/26.
//

import Foundation

protocol SaveVideoUseCaseProtocol {
    func execute(videoURL: URL) async throws
}

final class SaveVideoUseCase: SaveVideoUseCaseProtocol {
    private let repository: VideoRepositoryProtocol
    
    init(repository: VideoRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(videoURL: URL) async throws {
        try await repository.saveToPhotoLibrary(videoURL: videoURL)
    }
}
