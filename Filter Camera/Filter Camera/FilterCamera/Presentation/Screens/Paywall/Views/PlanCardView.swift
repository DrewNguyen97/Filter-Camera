//
//  PlanCardView.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 8/5/26.
//

import SwiftUI

struct PlanCardView: View {
    let plan: SubscriptionPlan
    let isSelected: Bool
    let onTap: () -> Void

    private var scale: CGFloat {
        isSelected ? 1.2 : 0.8
    }

    var body: some View {
        Button(action: onTap) {
            
            VStack(spacing: 4) {
                Text(plan.name)
                    .font(AppTypography.title4)
                    .foregroundColor(isSelected ? AppColor.text1 : AppColor.primary)
                
                Text(plan.price)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(AppColor.text1)
                
                Text(plan.subtext ?? "")
                    .font(.system(size: 11))
                    .foregroundColor(isSelected ? Color.purple.opacity(0.7) : AppColor.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: AppCornerRadius.lg)
                    .fill(isSelected ? AppColor.selectedBackground : AppColor.cardBackground)
            )
            .overlay(
                RoundedRectangle(cornerRadius: AppCornerRadius.lg)
                    .stroke(
                        isSelected ? AppColor.selectedBorder : AppColor.cardBorder,
                        lineWidth: isSelected ? 5 : 2
                    )
                    .offset(y: isSelected ? -1 : 0)
                    .clipShape(RoundedRectangle(cornerRadius: AppCornerRadius.lg))
            )
        }
        .buttonStyle(.plain)
        .overlay(alignment: .topTrailing) {
            if plan.isBestOffer {
                Image(AppImage.verify)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .offset(x: -6, y: 6)
            }
        }
        .overlay(alignment: .top) {
            if plan.isBestOffer {
                Text(AppText.bestOffer)
                    .font(AppTypography.extraText)
                    .foregroundColor(AppColor.text1)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        Capsule()
                            .fill(AppColor.primary)
                            .shadow(color: Color.black.opacity(0.25), radius: 0, x: 0, y: 1)
                    )
                    .offset(y: -12)
            }
        }
        .padding(.top, plan.isBestOffer ? 12 : 0)
        .scaleEffect(scale, anchor: .bottom)
        .animation(.spring(response: 0.35, dampingFraction: 0.65), value: isSelected)
    }
}
