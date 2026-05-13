//
//  CameraViewModel.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 11/5/26.
//

import SwiftUI
import AVFoundation
import Combine

// MARK: - Camera ViewModel
final class CameraViewModel: ObservableObject {
    @Published var recordingState: RecordingState = .idle
    @Published var selectedDuration: RecordingDuration = .fifteen
    @Published var isPremium: Bool = false
    @Published var error: String?
    @Published var isSessionReady = false
    @Published var countdownValue: Int = 3
    @Published var showCountdown = false
    @Published var isFlashOn = false
    @Published var shouldNavigateToPaywall = false

    // Timer
    private var recordingTimer: Timer?
    private var countdownTimer: Timer?
    private var elapsedTime: TimeInterval = 0
    private var recordingURL: URL?

    let cameraService: CameraServiceProtocol
    private let checkPremiumUseCase: CheckPremiumUseCaseProtocol

    var session: AVCaptureSession { cameraService.session }

    init(cameraService: CameraServiceProtocol,
         checkPremiumUseCase: CheckPremiumUseCaseProtocol) {
        self.cameraService = cameraService
        self.checkPremiumUseCase = checkPremiumUseCase
    }

    // MARK: - Lifecycle
    func onAppear() {
        isPremium = checkPremiumUseCase.execute()
        Task {
            await setupCamera()
        }
    }

    func onDisappear() {
        stopRecordingTimer()
        cameraService.stopSession()
    }

    private func setupCamera() async {
        do {
            try await cameraService.configure()
            await MainActor.run {
                isSessionReady = true
                cameraService.startSession()
            }
        } catch {
            await MainActor.run {
                self.error = error.localizedDescription
            }
        }
    }

    // MARK: - Duration Selection
    func selectDuration(_ duration: RecordingDuration) {
        guard case .idle = recordingState else { return }
        withAnimation(.spring(response: 0.3)) {
            selectedDuration = duration
        }
    }

    // MARK: - Recording
    func toggleRecording() {
        switch recordingState {
        case .idle:
            startCountdown()
        case .recording:
            stopRecording()
        default:
            break
        }
    }

    private func startCountdown() {
        countdownValue = 3
        showCountdown = true

        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self else { timer.invalidate(); return }
            if self.countdownValue > 1 {
                self.countdownValue -= 1
            } else {
                timer.invalidate()
                self.showCountdown = false
                self.beginActualRecording()
            }
        }
    }

    private func beginActualRecording() {
        let url = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("mov")
        recordingURL = url
        elapsedTime = 0

        cameraService.startRecording(to: url)

        withAnimation { recordingState = .recording(elapsed: 0, total: Double(selectedDuration.rawValue)) }

        // Progress timer
        recordingTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self else { return }
            self.elapsedTime += 0.1
            self.recordingState = .recording(
                elapsed: self.elapsedTime,
                total: Double(self.selectedDuration.rawValue)
            )
            if self.elapsedTime >= Double(self.selectedDuration.rawValue) {
                self.stopRecording()
            }
        }
    }

    private func stopRecording() {
        stopRecordingTimer()

        Task {
            do {
                let url = try await cameraService.stopRecording()
                await MainActor.run {
                    withAnimation {
                        recordingState = .finished(url)
                    }
                }
            } catch {
                await MainActor.run {
                    recordingState = .failed(error)
                    self.error = error.localizedDescription
                }
            }
        }
    }

    private func stopRecordingTimer() {
        recordingTimer?.invalidate()
        recordingTimer = nil
        countdownTimer?.invalidate()
        countdownTimer = nil
    }

    // MARK: - Action
    func back() {
        shouldNavigateToPaywall = true
    }
    
    func toggleFlash() {
        let newState = !isFlashOn
        do {
            try cameraService.toggleTorch(isEnabled: newState)
            isFlashOn = newState
        } catch {
            self.error = error.localizedDescription
        }
    }
   
    func flipCamera() {
        do {
            try cameraService.flipCamera()
        }
        catch {
            self.error = error.localizedDescription
        }
    }
    
    
    // MARK: - Helpers
    var recordingProgress: Double {
        guard case .recording(let elapsed, let total) = recordingState else { return 0 }
        return elapsed / total
    }

    var elapsedDisplayString: String {
        guard case .recording(let elapsed, _) = recordingState else { return "00:00" }
        let seconds = Int(elapsed)
        return String(format: "%02d:%02d", seconds / 60, seconds % 60)
    }

    var isRecording: Bool {
        if case .recording = recordingState { return true }
        return false
    }
}
