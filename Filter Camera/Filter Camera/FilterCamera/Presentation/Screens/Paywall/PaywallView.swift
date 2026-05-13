//
//  PaywallView.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 8/5/26.
//

import SwiftUI
import Combine

// MARK: - Paywall View
struct PaywallView: View {
    @StateObject var viewModel: PaywallViewModel
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        ZStack(alignment: .topLeading) {
            AppColor.surface.ignoresSafeArea()

            mainContent

            closeButton
                .padding(.leading, AppSpacing.md)
        }
        .onAppear(perform: viewModel.onAppear)
        .onChange(of: viewModel.shouldNavigateToCamera) { should in
            if should {
                coordinator.navigateToCamera()
            }
        }
        .alert(AppText.error, isPresented: $viewModel.isShowingError) {
            Button(AppText.ok, action: viewModel.clearError)
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }

    // MARK: - Subviews

    private var mainContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                headerImage
                VStack(spacing: AppSpacing.xl) {
                    Text(AppText.randomFilterPremium)
                        .font(AppTypography.title1)
                        .foregroundColor(AppColor.text1)
                    planSelector
                    Text(AppText.premiumBenefits)
                        .font(AppTypography.title3)
                        .foregroundColor(AppColor.text1)
                    benefitsView
                    ctaButton
                }
                footerActions
            }
        }
        .ignoresSafeArea(edges: .top)
    }

    private var headerImage: some View {
        Image(AppImage.paywall)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity)
            .ignoresSafeArea(edges: .top)
    }

    @ViewBuilder
    private var planSelector: some View {
        if !viewModel.plans.isEmpty {
            PlanPickerView(
                plans: viewModel.plans,
                selectedPlan: $viewModel.selectedPlan
            )
            .padding(.horizontal, AppSpacing.lg)
        }
    }

    private var benefitsView: some View {
        Image(AppImage.paywallBenefit)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal, AppSpacing.lg)
    }

    @ViewBuilder
    private var closeButton: some View {
        if viewModel.showCloseButton {
            Button(action: viewModel.close) {
                Image(systemName: "xmark")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44)
                    .background(Color.white.opacity(0.4))
                    .clipShape(Circle())
            }
            .transition(.scale.combined(with: .opacity))
        }
    }

    // MARK: - CTA Button
    private var ctaButton: some View {
        Button(action: {
            viewModel.purchase()
        }) {
            Group {
                if case .loading = viewModel.purchaseState {
                    ProgressView().progressViewStyle(.circular).tint(.white)
                } else {
                    Text(AppText.continueAction)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
            }
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .background(AppColor.buttonContinue)
            .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.lg))
            .overlay(
                RoundedRectangle(cornerRadius: AppCornerRadius.lg)
                    .stroke(AppColor.buttonContinueBorder, lineWidth: 5)
                    .offset(y: -1)
                    .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.lg))
            )
        }
        .disabled(viewModel.purchaseState == .loading)
        .padding(.horizontal, AppSpacing.lg)
    }

    // MARK: - Footer
    private var footerActions: some View {
        HStack {
            Button(AppText.privacyPolicy) {
                viewModel.showPolicy()
            }
                .underline()
                .font(AppTypography.subheadline)
                .foregroundColor(AppColor.text1)
                .frame(maxWidth: .infinity, alignment: .leading)

            Button(AppText.restore) {
                viewModel.restore()
            }
            .font(AppTypography.footnote)
            .foregroundColor(AppColor.text1)
            .padding(.vertical)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Button(AppText.terms) {
                viewModel.showTerm()
            }
                .underline()
                .font(AppTypography.subheadline)
                .foregroundColor(AppColor.text1)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, AppSpacing.lg)
    }
}
