//
//  VideoRepository.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import Foundation

final class VideoRepository: VideoRepositoryProtocol {
    private let photoLibraryService: PhotoLibraryServiceProtocol

    init(photoLibraryService: PhotoLibraryServiceProtocol) {
        self.photoLibraryService = photoLibraryService
    }

    func saveToPhotoLibrary(videoURL: URL) async throws {
        try await photoLibraryService.saveVideo(at: videoURL)
    }
}
