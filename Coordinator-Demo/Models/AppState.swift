//
//  AppState.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import Foundation

@Observable
class AppState {
    // MARK: - Direct Mutation Demo
    // SwiftUI views can toggle/update these directly.
    // This demonstrates the "direct @Observable mutation" data pattern.
    var favoriteItemIDs: Set<UUID> = []
    var username: String = "Gavin"
    var notificationsEnabled: Bool = true

    // MARK: - Computed
    var favoriteCount: Int { favoriteItemIDs.count }

    func isFavorite(_ id: UUID) -> Bool {
        favoriteItemIDs.contains(id)
    }

    func toggleFavorite(_ id: UUID) {
        if favoriteItemIDs.contains(id) {
            favoriteItemIDs.remove(id)
        } else {
            favoriteItemIDs.insert(id)
        }
    }
}
