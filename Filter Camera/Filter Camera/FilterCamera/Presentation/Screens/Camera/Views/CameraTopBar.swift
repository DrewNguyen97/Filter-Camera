//
//  CameraTopBar.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 12/5/26.
//

import SwiftUI

struct CameraTopBar: View {
    @ObservedObject var viewModel: CameraViewModel
    
    var body: some View {
        VStack(spacing: AppSpacing.sm) {
            // Ads banner (hidden for premium)
            if !viewModel.isPremium {
                NativeAdBannerView(size: .small, adUnitID: AdUnitID.nativeCamera)
                    .frame(maxWidth: .infinity)
            } else {
                Spacer().frame(height: 10)
            }
            
            actionBar
        }
        .padding(.top, AppSpacing.md)
        .padding(.horizontal, AppSpacing.md)
    }
    
    private var actionBar: some View {
        VStack(spacing: AppSpacing.md) {
            HStack(spacing: AppSpacing.md) {
                if !viewModel.isPremium {
                    Button(action: { viewModel.back() }) {
                        Image(systemName: AppImage.back)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 36, height: 36)
                            .background(AppColor.cameraControlBg)
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
                
                // Add Music Button
                Button(action: { /* Logic */ }) {
                    HStack(spacing: 4) {
                        Image(systemName: AppImage.plusCircle)
                            .font(.system(size: 13, weight: .bold))
                        Text(AppText.addMusic)
                            .font(.system(size: 14, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .padding(AppSpacing.sm)
                    .background(AppColor.cameraControlBg)
                    .clipShape(Capsule())
                }
                
                // Premium Features Button
                Button(action: { /* Logic */ }) {
                    HStack(spacing: 4) {
                        Image(systemName: AppImage.wandSparkles)
                            .font(.system(size: 13, weight: .bold))
                        Text("+99")
                            .font(.system(size: 14, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .padding(AppSpacing.sm)
                    .background(AppColor.cameraControlBg)
                    .clipShape(Capsule())
                }
                
                // Crown Button
                Button(action: { /* Logic */ }) {
                    Image(systemName: AppImage.crown)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(AppColor.cameraControlBg)
                        .clipShape(Circle())
                }
            }
            
            VStack(spacing: AppSpacing.md) {
                // Flash Toggle
                Button(action: { viewModel.toggleFlash() }) {
                    Image(systemName: viewModel.isFlashOn ? AppImage.flashOn : AppImage.flashOff)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(AppColor.cameraControlBg)
                        .clipShape(Circle())
                }
                
                // Flip Camera
                Button(action: { viewModel.flipCamera() }) {
                    Image(systemName: AppImage.flipCamera)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 36, height: 36)
                        .background(AppColor.cameraControlBg)
                        .clipShape(Circle())
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
