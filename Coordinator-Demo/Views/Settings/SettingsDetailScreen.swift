//
//  SettingsDetailScreen.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import SwiftUI

struct SettingsDetailScreen: View {
    var body: some View {
        List {
            Section("About") {
                LabeledContent("App", value: "Coordinator Demo")
                LabeledContent("Version", value: "1.0")
                LabeledContent("Architecture", value: "UIKit + SwiftUI")
            }

            Section {
                Text("This screen was pushed onto the Settings coordinator's own navigation stack, demonstrating that modal coordinators can manage their own navigation hierarchy.")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Settings Detail")
    }
}
