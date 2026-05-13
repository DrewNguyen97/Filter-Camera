//
//  RecordButton.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 12/5/26.
//

import SwiftUI

struct RecordButton: View {
    let isRecording: Bool
    let action: () -> Void

    @State private var isPulsing = false

    var body: some View {
        Button(action: action) {
            ZStack {
                // Pulse ring (animates while recording)
                if isRecording {
                    Circle()
                        .stroke(AppColor.primary.opacity(0.4), lineWidth: 3)
                        .frame(width: 90, height: 90)
                        .scaleEffect(isPulsing ? 1.3 : 1.0)
                        .opacity(isPulsing ? 0 : 1)
                        .animation(.easeOut(duration: 1).repeatForever(autoreverses: false), value: isPulsing)
                }

                // Outer ring
                Circle()
                    .stroke(Color.white, lineWidth: 3)
                    .frame(width: 80, height: 80)

                // Inner button
                RoundedRectangle(cornerRadius: isRecording ? 8 : 35)
                    .fill(isRecording ? AnyShapeStyle(AppColor.primary) : AnyShapeStyle(AppGradient.recordButton))
                    .frame(
                        width: isRecording ? 32 : 64,
                        height: isRecording ? 32 : 64
                    )
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isRecording)

                if !isRecording {
                    Circle()
                        .fill(AppGradient.recordButton)
                        .frame(width: 64, height: 64)
                }
            }
        }
        .onAppear {
            if isRecording { isPulsing = true }
        }
        .onChange(of: isRecording) { recording in
            if recording { isPulsing = true } else { isPulsing = false }
        }
    }
}
