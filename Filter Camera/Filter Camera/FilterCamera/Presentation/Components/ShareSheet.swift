//
//  ShareSheet.swift
//  Filter Camera
//
//  Created by Dung Tan Nguyen on 12/5/26.
//

import SwiftUI

// MARK: - Share Sheet
struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }

    func updateUIViewController(_ vc: UIActivityViewController, context: Context) {}
}
