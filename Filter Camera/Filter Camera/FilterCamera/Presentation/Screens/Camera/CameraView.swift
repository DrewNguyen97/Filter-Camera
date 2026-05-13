//
//  CameraView.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 11/5/26.
//

import SwiftUI
import AVFoundation
import Combine

// MARK: - Camera View
struct CameraView: View {
    @StateObject var viewModel: CameraViewModel
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if viewModel.isSessionReady {
                CameraPreviewView(session: viewModel.session)
                    .ignoresSafeArea()
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
                    .scaleEffect(1.5)
            }

            // Overlay UI
            VStack(spacing: 0) {
                // Top bar
                CameraTopBar(viewModel: viewModel)

                Spacer()

                // Countdown overlay
                if viewModel.showCountdown {
                    countdownOverlay
                }

                // Bottom controls
                CameraBottomControls(viewModel: viewModel)
            }

            // Error toast
            if let error = viewModel.error {
                errorToast(message: error)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
        .onReceive(viewModel.$recordingState.dropFirst()) { state in
            if case .finished(let url) = state {
                coordinator.navigateToResult(videoURL: url)
            }
        }
        .onChange(of: viewModel.shouldNavigateToPaywall) { should in
            if should {
                coordinator.navigateToPaywall(true)
            }
        }
    }

    // MARK: - Countdown Overlay
    private var countdownOverlay: some View {
        Text("\(viewModel.countdownValue)")
            .font(.system(size: 96, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .shadow(color: AppColor.primary, radius: 30)
            .transition(.scale.combined(with: .opacity))
            .animation(.spring(response: 0.4), value: viewModel.countdownValue)
    }

    // MARK: - Error Toast
    private func errorToast(message: String) -> some View {
        VStack {
            Spacer()
            Text(message)
                .font(AppTypography.footnote)
                .foregroundColor(.white)
                .padding(.horizontal, AppSpacing.md)
                .padding(.vertical, AppSpacing.sm)
                .background(AppColor.error.opacity(0.85))
                .clipShape(Capsule())
                .padding(.bottom, 100)
        }
    }
}
