//
//  ProfileScreen.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import SwiftUI

struct ProfileScreen: View {
    var appState: AppState
    var onSettingsTapped: (() -> Void)?
    var onSaveProfile: ((String) -> Void)?

    @State private var editedUsername: String = ""

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $editedUsername)
                Button("Save") {
                    onSaveProfile?(editedUsername)
                }
            } header: {
                Text("Profile")
            } footer: {
                Text("Closure-based update — flows through the coordinator")
                    .font(.caption2)
            }

            Section("Stats") {
                LabeledContent("Favorites", value: "\(appState.favoriteCount)")
            }
        }
        .onAppear {
            editedUsername = appState.username
        }
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
