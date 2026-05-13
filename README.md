# Filter Camera

An iOS camera application that allows users to record videos with random filters, preview results, and save/share their recordings.

---

## Build & Run Instructions

**Requirements:**
- Xcode 16+ (tested on Xcode 26 beta)
- iOS 16.0+
- Swift 5.9+
- CocoaPods or Swift Package Manager

**Steps:**

```bash
# 1. Clone the repository
git clone https://github.com/your-username/filter-camera.git
cd filter-camera

# 2. Install dependencies (if using CocoaPods)
pod install

# 3. Open workspace
open FilterCamera.xcworkspace
```

4. Select the `Filter Camera` scheme and a target device (physical iPhone recommended — camera does not run on Simulator)
5. Build & Run (`⌘R`)

**StoreKit Testing:**
- Open `FilterCamera.storekit` → attach to scheme via `Product → Scheme → Edit Scheme → Run → Options → StoreKit Configuration`
- Product IDs: `filtercamera.premium.weekly`, `filtercamera.premium.monthly`, `filtercamera.premium.yearly`

---

## Architecture

The project uses **MVVM-C (Model-View-ViewModel + Coordinator)**.

```
App
├── Coordinator
│   └── AppCoordinator          — Manages the entire navigation flow
├── Screens
│   ├── Splash
│   ├── Onboarding
│   ├── Paywall
│   ├── Camera
│   └── Result
├── Domain
│   ├── UseCases                — Business logic (Purchase, FetchProducts, CheckPremium...)
│   └── Protocols               — Abstraction layer (CameraServiceProtocol, UseCaseProtocols)
├── Data
│   ├── Services                — CameraService, StoreKit service
│   └── Repositories
└── Common
    ├── DesignSystem            — AppColor, AppTypography, AppSpacing...
    └── Extensions
```

**Why MVVM-C:**
- Coordinator cleanly separates navigation logic from Views, making both easier to test and extend
- ViewModels have no UIKit/SwiftUI dependency → independently unit-testable
- UseCase layer allows business logic reuse across screens (e.g. `CheckPremiumUseCase` is injected into every screen that shows ads)

---

## Third-Party Libraries

| Library | Purpose | Reason |
|---|---|---|
| **Google Mobile Ads SDK** | AdMob Interstitial + Native Ads | Required by spec; official Google SDK |
| **StoreKit 2** (built-in) | In-App Purchase | Native Apple framework with async/await support — no third-party needed |

No additional libraries were used. Apple-native frameworks (AVFoundation, Metal, Core Image, Vision) were preferred to minimize dependencies and maximize performance.

---

## Completed Features

| # | Feature | Notes |
|---|---|---|
| ✅ | Splash Screen + loading animation | Auto-transitions after 2–3 seconds |
| ✅ | Interstitial Ad on Splash | Shown before navigating to Onboarding |
| ✅ | 3-step Onboarding | SwiftUI TabView + PageIndicator, state persisted via UserDefaults |
| ✅ | Native Ads (medium) on Onboarding | Hidden gracefully on load failure |
| ✅ | Paywall | Weekly / Monthly / Yearly plans, close button appears after 5s |
| ✅ | StoreKit 2 In-App Purchase | Fetches live prices from App Store, sandbox testing supported |
| ✅ | Camera preview (AVFoundation) | Front/back camera, torch toggle |
| ✅ | Video recording (15s / 30s / 60s / 120s) | Auto-stops at time limit, countdown timer |
| ✅ | Flip camera | Switches between front and back via AVCaptureDevice |
| ✅ | Record button animation | Pulse animation while recording |
| ✅ | Filter picker UI | Horizontal scroll, 8 CI filter options |
| ✅ | Core Image filters | Vivid, Noir, Fade, Chrome, Warm, Cool, Vintage |
| ✅ | Result screen | Video playback, Save, Retry |
| ✅ | Native Ads (large) on Result | NativeAdBannerView |
| ✅ | Save video to Photos | PHPhotoLibrary with permission request |
| ✅ | Hide ads for Premium users | CheckPremiumUseCase injected into all ad-bearing screens |
| ✅ | Responsive layout | Tested on iPhone SE, 14, and 15 Pro Max |
| ✅ | Permission handling | Camera, Microphone, Photo Library with descriptive usage strings |
| ✅ | Share video | UIActivityViewController wired into the Result screen |

---

## Incomplete / Missing Features

| # | Feature | Reason / Notes |
|---|---|---|
| ⚠️ | **Live filter applied to camera preview** | The filter picker UI and `CameraFilterOption` with full `CIFilter` chains are built. However, `CameraService` currently uses `AVCaptureVideoPreviewLayer`, which renders directly from the camera hardware and does not allow pixel buffer interception. Switching to `AVCaptureVideoDataOutput` + `MTKView` is required to apply `CIFilter` in real time. |
| ⚠️ | **Filter baked into recorded video** | A custom `AVAssetWriter` pipeline is needed to write filtered frames. The current `AVCaptureMovieFileOutput` approach bypasses the filter entirely. |
| ⚠️ | **Ring overlay filter (reference video)** | PNG assets (`img_ring`, `img_circle`) are included, Metal shaders (`RingFilterShaders.metal`) are written, and the physics engine (`RingPhysicsEngine`) is implemented. Integration into the camera recording flow is not yet complete. |


---

## GPU Camera Processing

> This section describes the proposed GPU pipeline design for the optional requirement.

## Improvements Given More Time

**1. Complete the GPU filter pipeline**
Highest priority. Replacing `CameraPreviewView`'s `AVCaptureVideoPreviewLayer` with an `MTKView` + `AVCaptureVideoDataOutput` pipeline would make filters apply in real time to both the preview and the recorded video output.

**2. Ring overlay filter (reference video)**
Create AI Ring filter

**3. Unit tests**
All ViewModels and UseCases are designed for testability (protocol-based dependency injection), but test cases have not been written yet.

**4. Richer error / offline UX**
Currently errors are surfaced as plain strings. A retry flow with better visual feedback would improve the experience when StoreKit or camera setup fails.

---

## Video Demo

<video src="./demo/demo1.mp4" width="250" controls></video>
<video src="./demo/demo2.mp4" width="250" controls></video>
