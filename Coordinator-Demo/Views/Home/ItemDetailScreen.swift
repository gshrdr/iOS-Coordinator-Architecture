//
//  ItemDetailScreen.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import SwiftUI

struct ItemDetailScreen: View {
    let item: Item
    var appState: AppState

    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    Image(systemName: item.iconName)
                        .font(.system(size: 48))
                        .foregroundStyle(.primary)

                    Text(item.title)
                        .font(.title2.bold())

                    Text(item.subtitle)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
            }

            Section {
                Button {
                    appState.toggleFavorite(item.id)
                } label: {
                    HStack {
                        Image(systemName: appState.isFavorite(item.id) ? "heart.fill" : "heart")
                            .foregroundStyle(appState.isFavorite(item.id) ? .red : .primary)
                        Text(appState.isFavorite(item.id) ? "Unfavorite" : "Favorite")
                    }
                }
            } footer: {
                Text("Direct @Observable mutation — no coordinator involved")
                    .font(.caption2)
            }
        }
        .navigationTitle(item.title)
    }
}
