//
//  CameraBottomControls.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 12/5/26.
//

import SwiftUI

struct CameraBottomControls: View {
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            if viewModel.isRecording {
                recordingProgress
            }
            
            if !viewModel.isRecording {
                durationSelector
            }

            HStack {
                Spacer()
                RecordButton(isRecording: viewModel.isRecording) {
                    viewModel.toggleRecording()
                }
                Spacer()
            }
        }
        .padding(.bottom, 48)
        .padding(.horizontal, AppSpacing.md)
        .background(
            LinearGradient(
                colors: [.clear, .black.opacity(0.7)],
                startPoint: .top, endPoint: .bottom
            )
        )
    }
    
    private var recordingProgress: some View {
        VStack(spacing: AppSpacing.sm) {
            Text(viewModel.elapsedDisplayString)
                .font(AppTypography.timerFont)
                .foregroundColor(.white)
                .monospacedDigit()

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.white.opacity(0.2)).frame(height: 4)
                    Capsule()
                        .fill(AppColor.primary)
                        .frame(width: geo.size.width * viewModel.recordingProgress, height: 4)
                        .animation(.linear(duration: 0.1), value: viewModel.recordingProgress)
                }
            }
            .frame(height: 4)
            .padding(.horizontal, AppSpacing.xl)
        }
    }
    
    private var durationSelector: some View {
        HStack(spacing: AppSpacing.sm) {
            ForEach(RecordingDuration.allCases) { duration in
                Button(action: {
                    viewModel.selectDuration(duration)
                }) {
                    Text(duration.displayText)
                        .font(AppTypography.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(viewModel.selectedDuration == duration
                                         ? .white
                                         : .white.opacity(0.6))
                        .padding(.horizontal, AppSpacing.md)
                        .padding(.vertical, AppSpacing.sm)
                        .background(
                            Capsule()
                                .fill(viewModel.selectedDuration == duration
                                      ? Color.white.opacity(0.3)
                                      : Color.white.opacity(0.1))
                        )
                }
            }
        }
    }
}
