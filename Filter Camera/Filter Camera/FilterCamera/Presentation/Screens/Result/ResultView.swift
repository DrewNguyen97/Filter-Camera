//
//  ResultView.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 12/5/26.
//

import SwiftUI
import AVKit

// MARK: - Result View
struct ResultView: View {
    @StateObject var viewModel: ResultViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    @State private var player: AVPlayer?

    var body: some View {
        ZStack {
            AppColor.resultBackground.ignoresSafeArea()
            VStack(spacing: 0) {
                navBar
                videoCard
                    .padding(.horizontal, AppSpacing.lg)
                    .padding(.top, AppSpacing.md)
                    .padding(.bottom, AppSpacing.sm)
                
                ResultBottomPanel(
                    viewModel: viewModel,
                    onRetry: {
                        coordinator.retryCamera() }
                    )
                }

            if viewModel.saveSuccess {
                SaveSuccessToast()
            }
        }
        .onAppear {
            setupPlayer()
        }
        .onDisappear {
            player?.pause()
            player = nil
        }
        .sheet(isPresented: $viewModel.isSharing) {
            ShareSheet(items: [viewModel.videoURL])
        }
        .alert(AppText.error, isPresented: .constant(viewModel.errorMessage != nil)) {
            Button(AppText.ok) {
                viewModel.errorMessage = nil
            }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }

    private func setupPlayer() {
        player = AVPlayer(url: viewModel.videoURL)
        player?.play()
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem,
            queue: .main
        ) { [weak player] _ in
            player?.seek(to: .zero)
            player?.play()
        }
    }
    
    private var navBar: some View {
        HStack {
            Button(action: {
                coordinator.retryCamera()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(AppColor.textPrimary)
                    .frame(width: 44, height: 44)
            }
            Spacer()
            Text(AppText.result)
                .font(AppTypography.title3)
                .foregroundColor(AppColor.textPrimary)
            Spacer()
            Color.clear.frame(width: 44, height: 44)
        }
        .padding(.horizontal, AppSpacing.sm)
    }
    
    private var videoCard: some View {
        Group {
            VideoPlayer(player: AVPlayer(url: viewModel.videoURL))
                    .aspectRatio(9/16, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.xl))
                    .frame(width: UIScreen.main.bounds.width / 2)
            }
            .background(
                RoundedRectangle(cornerRadius: AppCornerRadius.xl)
                    .fill(Color.white)
            )
    }
}
