import Foundation
import AVFoundation
import StoreKit

// MARK: - UserDefaults Service Protocol
protocol UserDefaultsServiceProtocol {
    func bool(forKey key: String) -> Bool
    func set(_ value: Bool, forKey key: String)
    func string(forKey key: String) -> String?
    func set(_ value: String, forKey key: String)
}

// MARK: - Camera Service Protocol
protocol CameraServiceProtocol: AnyObject {
    var session: AVCaptureSession { get }
    var isTorchAvailable: Bool { get }
    var isRecording: Bool { get }
    var currentCameraPosition: AVCaptureDevice.Position { get }
    func configure() async throws
    func startSession()
    func stopSession()
    func startRecording(to url: URL)
    func stopRecording() async throws -> URL
    func flipCamera() throws
    func toggleTorch(isEnabled: Bool) throws
}

// MARK: - Photo Library Service Protocol
protocol PhotoLibraryServiceProtocol {
    func saveVideo(at url: URL) async throws
    func requestAuthorization() async -> Bool
}

// MARK: - Purchase Service Protocol
protocol PurchaseServiceProtocol {
    func purchase(productID: String) async throws -> Bool
    func restorePurchases() async throws -> Bool
    func fetchProducts(ids: [String]) async throws -> [Product]
}
