import Photos

enum PhotoLibraryError: LocalizedError {
    case notAuthorized

    var errorDescription: String? {
        "Photo Library access not authorized."
    }
}

final class PhotoLibraryService: PhotoLibraryServiceProtocol {

    func requestAuthorization() async -> Bool {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        if status == .authorized || status == .limited {
            return true
        }
        if status == .notDetermined {
            let result = await PHPhotoLibrary.requestAuthorization(for: .addOnly)
            return result == .authorized || result == .limited
        }
        return false
    }

    func saveVideo(at url: URL) async throws {
        let authorized = await requestAuthorization()
        guard authorized else {
            throw PhotoLibraryError.notAuthorized
        }

        try await PHPhotoLibrary.shared().performChanges {
            PHAssetCreationRequest.creationRequestForAssetFromVideo(atFileURL: url)
        }
    }
}
