//
//  OnboardingView.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import SwiftUI

// MARK: - Onboarding View
struct OnboardingView: View {
    @StateObject var viewModel: OnboardingViewModel
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        VStack(spacing: 0) {
            imageView
   
            Text(viewModel.pages[viewModel.currentPage].title)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Spacer(minLength: 12)
            
            pageControl
                .padding(.horizontal, 10)
            
            Spacer(minLength: 16)
            
            NativeAdBannerView(size: .medium, adUnitID: AdUnitID.nativeOnboarding)
                .padding(.horizontal, AppSpacing.md)
        }
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.white)
        .onChange(of: viewModel.shouldNavigateToPaywall) { should in
            if should {
                coordinator.navigateToPaywall()
            }
        }
    }
    
    private var imageView: some View {
        TabView(selection: $viewModel.currentPage) {
            ForEach(viewModel.pages, id: \.id) { page in
                OnboardingPageView(page: page)
                    .tag(page.id)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut, value: viewModel.currentPage)
    }
    
    private var pageControl: some View {
        HStack {
            HStack(spacing: 6) {
                ForEach(0..<viewModel.pages.count, id: \.self) { index in
                    Capsule()
                        .fill(index == viewModel.currentPage
                              ? AppColor.primaryLight
                              : AppColor.primaryLight.opacity(0.3))
                        .frame(width: index == viewModel.currentPage ? 18 : 8, height: 8)
                        .animation(.spring(), value: viewModel.currentPage)
                }
            }
            
            Spacer()
            
            Button(action: {
                viewModel.nextPage()
            }) {
                Text(AppText.next)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(AppColor.primaryLight)
            }
        }
        .padding(.horizontal, AppSpacing.xl)
    }
}

// MARK: - Onboarding Page View
struct OnboardingPageView: View {
    let page: OnboardingPage

    var body: some View {
        Image(page.imageName)
            .resizable()
            .ignoresSafeArea(edges: .top)
    }
}
