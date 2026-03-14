//
//  ExploreScreen.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import SwiftUI

struct ExploreScreen: View {
    var appState: AppState
    var onSettingsTapped: (() -> Void)?
    var onDeepLinkTest: (() -> Void)?

    private let topics: [(icon: String, title: String)] = [
        ("paintpalette.fill", "Design Patterns"),
        ("cpu", "Architecture"),
        ("lock.shield.fill", "Memory Safety"),
        ("arrow.2.squarepath", "Navigation"),
        ("rectangle.stack.fill", "View Hierarchy"),
        ("bell.badge.fill", "Notifications"),
    ]

    var body: some View {
        List {
            Section {
                Text("Hello, \(appState.username)")
                    .font(.headline)
            } footer: {
                Text("Shared state from AppState — updated across all tabs")
                    .font(.caption2)
            }

            Section("Topics") {
                ForEach(topics, id: \.title) { topic in
                    HStack(spacing: 14) {
                        Image(systemName: topic.icon)
                            .font(.title3)
                            .foregroundStyle(.primary)
                            .frame(width: 28)
                        Text(topic.title)
                    }
                    .padding(.vertical, 4)
                }
            }

            if let onDeepLinkTest {
                Section {
                    Button {
                        onDeepLinkTest()
                    } label: {
                        HStack {
                            Image(systemName: "link")
                            Text("Test Deep Link")
                        }
                    }
                } footer: {
                    Text("Navigates to Home tab and pushes the first item detail via deep linking")
                        .font(.caption2)
                }
            }
        }
        .contentMargins(.bottom, 20, for: .scrollContent)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onSettingsTapped?()
                } label: {
                    Image(systemName: "gearshape.fill")
                }
            }
        }
    }
}
