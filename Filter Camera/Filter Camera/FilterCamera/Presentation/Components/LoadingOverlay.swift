//
//  LoadingOverlay.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import SwiftUI

struct LoadingOverlay: View {
    let message: String

    var body: some View {
        ZStack {
            Color.black.opacity(0.6).ignoresSafeArea()
            VStack(spacing: AppSpacing.md) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
                    .scaleEffect(1.4)
                Text(message)
                    .font(AppTypography.callout)
                    .foregroundColor(.white)
            }
            .padding(AppSpacing.xl)
            .background(AppColor.surface)
            .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.xl))
        }
    }
}
