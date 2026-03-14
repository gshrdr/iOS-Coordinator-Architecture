//
//  SettingsScreen.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import SwiftUI

struct SettingsScreen: View {
    var appState: AppState
    var onDismiss: (() -> Void)?
    var onDetailTapped: (() -> Void)?
    var onResetOnboarding: (() -> Void)?

    var body: some View {
        Form {
            Section {
                Toggle("Notifications", isOn: Bindable(appState).notificationsEnabled)
            } header: {
                Text("Preferences")
            } footer: {
                Text("Direct @Observable mutation — no coordinator involved")
                    .font(.caption2)
            }

            Section {
                Button {
                    onDetailTapped?()
                } label: {
                    HStack {
                        Text("Settings Detail")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Section {
                Button("Reset Onboarding") {
                    onResetOnboarding?()
                }
            } footer: {
                Text("Re-launch the app to see onboarding again")
                    .font(.caption2)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Done") {
                    onDismiss?()
                }
            }
        }
    }
}
