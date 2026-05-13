//
//  NativeAdBannerView.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 6/5/26.
//

import SwiftUI
import GoogleMobileAds

// MARK: - Native Ad Size
enum NativeAdSize {
    case small, medium, large

    var height: CGFloat {
        switch self {
        case .small:  return 100
        case .medium: return 140
        case .large:  return 200
        }
    }
}

// MARK: - Native Ad Banner View
struct NativeAdBannerView: View {
    let size: NativeAdSize
    var adUnitID: String = AdUnitID.nativeOnboarding

    @StateObject private var adManager: NativeAdManager

    init(size: NativeAdSize, adUnitID: String = AdUnitID.nativeOnboarding) {
        self.size = size
        self.adUnitID = adUnitID
        _adManager = StateObject(wrappedValue: NativeAdManager(adUnitID: adUnitID))
    }

    var body: some View {
        Group {
            if let nativeAd = adManager.nativeAd {
                NativeAdRepresentable(nativeAd: nativeAd)
                    .frame(height: size.height)
                    .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.md))
            } else if adManager.isLoading {
                adLoadingPlaceholder
            } else if adManager.loadFailed {
                EmptyView()
            } else {
                adLoadingPlaceholder
            }
        }
        .onAppear {
            if adManager.nativeAd == nil && !adManager.isLoading {
                adManager.loadAd()
            }
        }
    }

    private var adLoadingPlaceholder: some View {
        HStack {
            Image(systemName: "rectangle.badge.checkmark")
                .font(.system(size: 20))
                .foregroundColor(AppColor.textTertiary)
            VStack(alignment: .leading, spacing: 2) {
                Text("Advertisement")
                    .font(AppTypography.caption)
                    .foregroundColor(AppColor.textTertiary)
                Text("Ad content will appear here")
                    .font(AppTypography.footnote)
                    .foregroundColor(AppColor.textTertiary.opacity(0.6))
            }
            Spacer()
            if adManager.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(0.7)
            } else {
                Text("AD")
                    .font(AppTypography.caption)
                    .fontWeight(.bold)
                    .foregroundColor(AppColor.textTertiary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(AppColor.textTertiary, lineWidth: 1)
                    )
            }
        }
        .padding(.horizontal, AppSpacing.md)
        .frame(height: size.height)
        .background(AppColor.surface.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.md))
        .overlay(
            RoundedRectangle(cornerRadius: AppCornerRadius.md)
                .stroke(AppColor.cardBorder, lineWidth: 1)
        )
    }
}

// MARK: - UIViewRepresentable for GADNativeAdView
struct NativeAdRepresentable: UIViewRepresentable {
    let nativeAd: GADNativeAd

    func makeUIView(context: Context) -> GADNativeAdView {
        let nativeAdView = GADNativeAdView()
        nativeAdView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.05)
        nativeAdView.layer.cornerRadius = 12
        nativeAdView.clipsToBounds = true

        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 8
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        nativeAdView.addSubview(iconImageView)
        nativeAdView.iconView = iconImageView

        let headlineLabel = UILabel()
        headlineLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        headlineLabel.textColor = .label
        headlineLabel.numberOfLines = 2
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false
        nativeAdView.addSubview(headlineLabel)
        nativeAdView.headlineView = headlineLabel

        let bodyLabel = UILabel()
        bodyLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        bodyLabel.textColor = .secondaryLabel
        bodyLabel.numberOfLines = 2
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        nativeAdView.addSubview(bodyLabel)
        nativeAdView.bodyView = bodyLabel

        let ctaButton = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 14, bottom: 6, trailing: 14)
        ctaButton.configuration = config
        ctaButton.backgroundColor = UIColor(red: 155/255, green: 77/255, blue: 202/255, alpha: 1.0)
        ctaButton.layer.cornerRadius = 14
        ctaButton.isUserInteractionEnabled = false
        ctaButton.translatesAutoresizingMaskIntoConstraints = false
        nativeAdView.addSubview(ctaButton)
        nativeAdView.callToActionView = ctaButton

        let adBadge = UILabel()
        adBadge.text = "Ad"
        adBadge.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        adBadge.textColor = .white
        adBadge.backgroundColor = UIColor(red: 155/255, green: 77/255, blue: 202/255, alpha: 0.8)
        adBadge.textAlignment = .center
        adBadge.layer.cornerRadius = 4
        adBadge.clipsToBounds = true
        adBadge.translatesAutoresizingMaskIntoConstraints = false
        nativeAdView.addSubview(adBadge)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: nativeAdView.leadingAnchor, constant: 12),
            iconImageView.topAnchor.constraint(equalTo: nativeAdView.topAnchor, constant: 12),
            iconImageView.widthAnchor.constraint(equalToConstant: 44),
            iconImageView.heightAnchor.constraint(equalToConstant: 44),
            headlineLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            headlineLabel.topAnchor.constraint(equalTo: nativeAdView.topAnchor, constant: 12),
            headlineLabel.trailingAnchor.constraint(equalTo: nativeAdView.trailingAnchor, constant: -12),
            bodyLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            bodyLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 4),
            bodyLabel.trailingAnchor.constraint(equalTo: nativeAdView.trailingAnchor, constant: -12),
            ctaButton.trailingAnchor.constraint(equalTo: nativeAdView.trailingAnchor, constant: -12),
            ctaButton.bottomAnchor.constraint(equalTo: nativeAdView.bottomAnchor, constant: -12),
            ctaButton.heightAnchor.constraint(equalToConstant: 28),
            adBadge.leadingAnchor.constraint(equalTo: nativeAdView.leadingAnchor, constant: 12),
            adBadge.bottomAnchor.constraint(equalTo: nativeAdView.bottomAnchor, constant: -12),
            adBadge.widthAnchor.constraint(equalToConstant: 24),
            adBadge.heightAnchor.constraint(equalToConstant: 16),
        ])

        return nativeAdView
    }

    func updateUIView(_ nativeAdView: GADNativeAdView, context: Context) {
        nativeAdView.nativeAd = nativeAd
        if let iconView = nativeAdView.iconView as? UIImageView { iconView.image = nativeAd.icon?.image }
        if let headlineView = nativeAdView.headlineView as? UILabel { headlineView.text = nativeAd.headline }
        if let bodyView = nativeAdView.bodyView as? UILabel {
            bodyView.text = nativeAd.body
            bodyView.isHidden = nativeAd.body == nil
        }
        if let ctaView = nativeAdView.callToActionView as? UIButton {
            ctaView.setTitle(nativeAd.callToAction, for: .normal)
            ctaView.isHidden = nativeAd.callToAction == nil
        }
    }
}
