//
//  PlanCardView.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 8/5/26.
//

import SwiftUI

struct PlanPickerView: View {
    let plans: [SubscriptionPlan]
    
    @Binding var selectedPlan: SubscriptionPlan

    var body: some View {
        HStack(spacing: 6) {
            ForEach(plans) { plan in
                PlanCardView(
                    plan: plan,
                    isSelected: plan.id == selectedPlan.id,
                    onTap: {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.65)) {
                            selectedPlan = plan
                        }
                    }
                )
            }
        }
        .padding(.top, 12)
    }
}
