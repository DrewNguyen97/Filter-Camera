//
//  ResultBottomPanel.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 12/5/26.
//

//
//  ResultBottomPanel.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 12/5/26.
//

import SwiftUI

struct ResultBottomPanel: View {
    @ObservedObject var viewModel: ResultViewModel
    let onRetry: () -> Void

    var body: some View {
        VStack(spacing: 0) {

            // MARK: Native Ad
            NativeAdBannerView(size: .large, adUnitID: AdUnitID.nativeResult)

            Divider()
                .padding(.bottom, AppSpacing.md)

            // MARK: Action Buttons
            VStack(spacing: AppSpacing.sm) {
                saveButton
                retryButton
                shareButton
            }
            .padding(.horizontal, AppSpacing.md)
            .padding(.bottom, AppSpacing.xs)
        }
    }

    // MARK: - Save
    private var saveButton: some View {
        Button(action: {
            viewModel.saveVideo()
        }) {
            HStack(spacing: 8) {
                if viewModel.isSaving {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                } else {
                    Image(systemName: AppImage.save)
                        .font(.system(size: 17, weight: .semibold))
                    Text(AppText.save)
                        .font(.system(size: 17, weight: .semibold))
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(
                RoundedRectangle(cornerRadius: AppCornerRadius.pill)
                    .fill(AppColor.text1)
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppCornerRadius.pill)
                    .stroke(Color.black.opacity(0.12), lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
        .disabled(viewModel.isSaving)
    }

    // MARK: - Retry
    private var retryButton: some View {
        Button(action: onRetry) {
            HStack(spacing: 6) {
                Image(systemName: AppImage.retry)
                    .font(.system(size: 14, weight: .semibold))
                Text(AppText.retry)
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(AppColor.ghostText)
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .background(
                RoundedRectangle(cornerRadius: AppCornerRadius.pill)
                    .fill(AppColor.splashBackgroundSolid)
            )
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Share
    private var shareButton: some View {
        Button(action: {
            viewModel.share()
        }) {
            HStack(spacing: 6) {
                Image(systemName: AppImage.share)
                    .font(.system(size: 20, weight: .medium))
                Text(AppText.share)
                    .font(AppTypography.caption)
            }
            .foregroundColor(AppColor.primary)
            .frame(maxWidth: .infinity)
            .frame(height: 46)
            .background(
                RoundedRectangle(cornerRadius: AppCornerRadius.pill)
                    .fill(AppColor.primary.opacity(0.1))
            )
        }
        .buttonStyle(.plain)
    }
}
