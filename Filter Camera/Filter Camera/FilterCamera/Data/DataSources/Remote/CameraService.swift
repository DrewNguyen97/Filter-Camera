import AVFoundation
import CoreImage
import UIKit

// MARK: - Camera Error
enum CameraError: LocalizedError {
    case notAuthorized
    case configurationFailed
    case captureSessionFailed
    case recordingFailed
    case noDeviceFound

    var errorDescription: String? {
        switch self {
        case .notAuthorized:     
            return "Camera access not authorized."
        case .configurationFailed: 
            return "Camera configuration failed."
        case .captureSessionFailed:
            return "Capture session failed."
        case .recordingFailed: 
            return "Recording failed."
        case .noDeviceFound:     
            return "No camera device found."
        }
    }
}

// MARK: - Camera Service
final class CameraService: NSObject, CameraServiceProtocol {

    // MARK: - Public
    let session = AVCaptureSession()
    private(set) var isRecording = false
    private(set) var currentCameraPosition: AVCaptureDevice.Position = .back
    var isTorchAvailable: Bool {
        return videoInput?.device.hasTorch ?? false
    }

    // MARK: - Private
    private var videoInput: AVCaptureDeviceInput?
    private var audioInput: AVCaptureDeviceInput?
    private let videoOutput = AVCaptureMovieFileOutput()
    private var recordingContinuation: CheckedContinuation<URL, Error>?

    // Filter pipeline
    private let ciContext = CIContext(options: [.useSoftwareRenderer: false])
    var activeFilter: CIFilter?

    // MARK: - Configure
    func configure() async throws {
        let authorized = await requestCameraAuthorization()
        guard authorized else {
            throw CameraError.notAuthorized
        }

        session.beginConfiguration()
        defer {
            session.commitConfiguration()
        }

        session.sessionPreset = .high

        // Video input
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let input = try? AVCaptureDeviceInput(device: device) else {
            throw CameraError.noDeviceFound
        }

        if session.canAddInput(input) {
            session.addInput(input)
            videoInput = input
        }

        // Audio input
        if let audioDevice = AVCaptureDevice.default(for: .audio),
           let audioIn = try? AVCaptureDeviceInput(device: audioDevice),
           session.canAddInput(audioIn) {
            session.addInput(audioIn)
            audioInput = audioIn
        }

        // Video output
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }
    }

    // MARK: - Session
    func startSession() {
        guard !session.isRunning else { return }
        Task(priority: .userInitiated) {
            session.startRunning()
        }
    }

    func stopSession() {
        guard session.isRunning else { return }
        Task.detached(priority: .background) {
            await self.session.stopRunning()
        }
    }

    // MARK: - Recording
    func startRecording(to url: URL) {
        guard !videoOutput.isRecording else { return }
        videoOutput.startRecording(to: url, recordingDelegate: self)
        isRecording = true
    }

    func stopRecording() async throws -> URL {
        try await withCheckedThrowingContinuation { continuation in
            recordingContinuation = continuation
            videoOutput.stopRecording()
        }
    }

    // MARK: - Flip Camera
    func flipCamera() throws {
        session.beginConfiguration()
        defer {
            session.commitConfiguration()
        }

        guard let currentInput = videoInput else {
            throw CameraError.noDeviceFound
        }

        let newPosition: AVCaptureDevice.Position = currentCameraPosition == .back ? .front : .back
        guard let newDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: newPosition),
              let newInput = try? AVCaptureDeviceInput(device: newDevice) else {
            throw CameraError.noDeviceFound
        }

        session.removeInput(currentInput)
        if session.canAddInput(newInput) {
            session.addInput(newInput)
            videoInput = newInput
            currentCameraPosition = newPosition
        }
    }

    // MARK: - Authorization
    private func requestCameraAuthorization() async -> Bool {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            return true
        case .notDetermined:
            return await AVCaptureDevice.requestAccess(for: .video)
        default: return false
        }
    }
    
    // MARK: - Togggle flash
    func toggleTorch(isEnabled: Bool) throws {
        guard let device = videoInput?.device, device.hasTorch else {
            throw CameraError.noDeviceFound
        }
        try device.lockForConfiguration()
        if isEnabled {
            if device.isTorchModeSupported(.on) {
                device.torchMode = .on
            }
        } else {
            if device.isTorchModeSupported(.off) {
                device.torchMode = .off
            }
        }
        device.unlockForConfiguration()
    }
}

// MARK: - AVCaptureFileOutputRecordingDelegate
extension CameraService: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput,
                    didFinishRecordingTo outputFileURL: URL,
                    from connections: [AVCaptureConnection],
                    error: Error?) {
        isRecording = false
        if let error = error {
            recordingContinuation?.resume(throwing: error)
        } else {
            recordingContinuation?.resume(returning: outputFileURL)
        }
        recordingContinuation = nil
    }
}
