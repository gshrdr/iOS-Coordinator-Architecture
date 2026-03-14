//
//  ExploreCoordinator.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import UIKit
import SwiftUI

final class ExploreCoordinator: Coordinator {
    var navigationController: UINavigationController!
    var childCoordinators: [Coordinator] = []
    var isNavigating: Bool = false

    var onSettingsTapped: (() -> Void)?
    var onDeepLinkTest: (() -> Void)?
    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    func start() {
        let exploreView = ExploreScreen(
            appState: appState,
            onSettingsTapped: { [weak self] in
                self?.onSettingsTapped?()
            },
            onDeepLinkTest: { [weak self] in
                self?.onDeepLinkTest?()
            }
        )

        let hostingController = UIHostingController(rootView: exploreView)
        hostingController.title = "Explore"

        navigationController = NavigationController(
            rootViewController: hostingController,
            isNavBarHidden: false
        )
    }

    deinit { print("[ExploreCoordinator] deinit") }
}
