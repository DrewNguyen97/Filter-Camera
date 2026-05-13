import SwiftUI
import Combine

// MARK: - Splash ViewModel
final class SplashViewModel: ObservableObject {
    enum Destination {
        case onboarding, paywall, camera
    }

    @Published var destination: Destination?
    @Published var isLoading = true
    @Published var loadingProgress: CGFloat = 0.0
    @Published private var minTimeElapsed = false
    @Published private var isPremiumUser = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private let checkOnboardingSeenUseCase: CheckOnboardingSeenUseCaseProtocol
    private let checkPremiumUseCase: CheckPremiumUseCaseProtocol

    init(checkOnboardingSeenUseCase: CheckOnboardingSeenUseCaseProtocol,
         checkPremiumUseCase: CheckPremiumUseCaseProtocol) {
        self.checkOnboardingSeenUseCase = checkOnboardingSeenUseCase
        self.checkPremiumUseCase = checkPremiumUseCase
    }

    func onAppear() {
        isPremiumUser = checkPremiumUseCase.execute()
        Publishers.CombineLatest(
            $minTimeElapsed,
            InterstitialAdManager.shared.$hasCompletedLoadAttempt
        )
        .receive(on: DispatchQueue.main)
        .sink { [weak self] (minTimeElapsed, adLoadAttemptCompleted) in
            guard let self = self else { return }
            if self.isPremiumUser {
                if minTimeElapsed {
                    self.finishLoadingAndNavigate()
                }
            } else {
                if minTimeElapsed && adLoadAttemptCompleted {
                    self.finishLoadingAndNavigate()
                }
            }
        }
        .store(in: &cancellables)
        
        if !isPremiumUser {
            Task {
                await InterstitialAdManager.shared.loadAd(adUnitID: AdUnitID.interstitialSplash)
            }
        }
        
        if isLoading {
            withAnimation(.easeOut(duration: 2.0)) {
                loadingProgress = 0.7
            }
        }
        
        Task { @MainActor [weak self] in
            try? await Task.sleep(for: .seconds(2.5))
            self?.minTimeElapsed = true
        }
    }

    private func finishLoadingAndNavigate() {
        guard isLoading else { return } // Prevent double execution
        isLoading = false
        withAnimation(.easeIn(duration: 0.2)) {
            loadingProgress = 1.0
        }
        Task {
            try? await Task.sleep(for: .seconds(0.3))
            if !self.isPremiumUser && InterstitialAdManager.shared.isLoaded {
                await self.showAdIfAvailable()
            } else {
                await MainActor.run {
                    self.determineDestination()
                }
            }
        }
    }

    private func showAdIfAvailable() async {
        await MainActor.run {
            self.determineDestination()
        }
        await InterstitialAdManager.shared.presentAd()
    }

    private func determineDestination() {
        if !checkOnboardingSeenUseCase.execute() {
            destination = .onboarding
        } else if checkPremiumUseCase.execute() {
            destination = .camera
        } else {
            destination = .paywall
        }
    }
}
