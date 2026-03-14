//
//  HomeScreen.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import SwiftUI

struct HomeScreen: View {
    var appState: AppState
    var onSettingsTapped: (() -> Void)?
    var onItemSelected: ((Item) -> Void)?

    var body: some View {
        List {
            Section {
                Text("\(appState.favoriteCount) favorites")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            ForEach(Item.samples) { item in
                Button {
                    onItemSelected?(item)
                } label: {
                    ItemRow(item: item, isFavorite: appState.isFavorite(item.id))
                }
                .tint(.primary)
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
