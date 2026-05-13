//
//  PermissionDeniedView.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 12/5/26.
//

import SwiftUI

struct PermissionDeniedView: View {
    let permission: String
    let onSettings: () -> Void

    var body: some View {
        VStack(spacing: AppSpacing.lg) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundColor(AppColor.warning)

            Text("\(permission) Access Required")
                .font(AppTypography.title3)
                .foregroundColor(AppColor.textPrimary)
                .multilineTextAlignment(.center)

            Text("Please grant \(permission) permission in Settings to use this feature.")
                .font(AppTypography.body)
                .foregroundColor(AppColor.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppSpacing.xl)

            Button(action: onSettings) {
                Text("Open Settings")
                    .font(AppTypography.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(AppColor.primary)
                    .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.lg))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColor.background)
    }
}
