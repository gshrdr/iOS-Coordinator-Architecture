//
//  ProfileCoordinator.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import UIKit
import SwiftUI

final class ProfileCoordinator: Coordinator {
    var navigationController: UINavigationController!
    var childCoordinators: [Coordinator] = []
    var isNavigating: Bool = false

    var onSettingsTapped: (() -> Void)?
    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    func start() {
        let profileView = ProfileScreen(
            appState: appState,
            onSettingsTapped: { [weak self] in
                self?.onSettingsTapped?()
            },
            onSaveProfile: { [weak self] newUsername in
                // CLOSURE-BASED DATA PATTERN:
                // The coordinator handles the side effect (could include
                // an API call, analytics event, or navigation) and then
                // updates the shared state.
                self?.appState.username = newUsername
                print("[ProfileCoordinator] Profile saved: \(newUsername)")
            }
        )

        let hostingController = UIHostingController(rootView: profileView)
        hostingController.title = "Profile"

        navigationController = NavigationController(
            rootViewController: hostingController,
            isNavBarHidden: false
        )
    }

    deinit { print("[ProfileCoordinator] deinit") }
}
