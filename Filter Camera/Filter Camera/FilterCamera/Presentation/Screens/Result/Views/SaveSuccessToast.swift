//
//  SaveSuccessToast.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 12/5/26.
//

import SwiftUI

struct SaveSuccessToast: View {
    var body: some View {
        VStack {
            HStack(spacing: AppSpacing.sm) {
                Image(systemName: AppImage.checkmarkCircle)
                    .foregroundColor(AppColor.success)
                Text(AppText.savedToPhotos)
                    .font(AppTypography.callout)
                    .foregroundColor(AppColor.textPrimary)
            }
            .padding(.horizontal, AppSpacing.lg)
            .padding(.vertical, AppSpacing.sm)
            .background(Color.white)
            .clipShape(Capsule())
            .shadow(color: AppShadow.card, radius: 12, y: 4)
            .padding(.top, 60)
            Spacer()
        }
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}
