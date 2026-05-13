//
//  ResultViewModel.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 11/5/26.
//

import Foundation
import Combine

// MARK: - Result ViewModel
final class ResultViewModel: ObservableObject {
    @Published var isSaving = false
    @Published var saveSuccess = false
    @Published var errorMessage: String?
    @Published var isSharing = false

    let videoURL: URL
    private let saveVideoUseCase: SaveVideoUseCaseProtocol

    init(videoURL: URL, saveVideoUseCase: SaveVideoUseCaseProtocol) {
        self.videoURL = videoURL
        self.saveVideoUseCase = saveVideoUseCase
    }

    func saveVideo() {
        guard !isSaving else { return }
        isSaving = true
        Task {
            do {
                try await saveVideoUseCase.execute(videoURL: videoURL)
                await MainActor.run {
                    isSaving = false
                    saveSuccess = true
                }
                try? await Task.sleep(for: .seconds(2))
                await MainActor.run { saveSuccess = false }
            } catch {
                await MainActor.run {
                    isSaving = false
                    errorMessage = error.localizedDescription
                }
            }
        }
    }

    func share() {
        isSharing = true
    }
}
