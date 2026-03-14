//
//  OnboardingView.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import SwiftUI

struct OnboardingView: View {
    var onComplete: (() -> Void)?

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Image(systemName: "arrow.triangle.branch")
                .font(.system(size: 80))
                .foregroundStyle(.primary)

            VStack(spacing: 12) {
                Text("Coordinator Demo")
                    .font(.largeTitle.bold())

                Text("A demo app showcasing the UIKit Coordinator pattern with SwiftUI views.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }

            Spacer()

            Button {
                onComplete?()
            } label: {
                Text("Get Started")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding(.horizontal, 32)
            .padding(.bottom, 48)
        }
    }
}
