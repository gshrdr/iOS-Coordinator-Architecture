//
//  MainTabCoordinator.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import UIKit

final class MainTabCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController!
    var isNavigating: Bool = false

    weak var appCoordinator: AppCoordinator?
    let tabBarController = PrimaryTabController()
    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    func start() {
        let homeCoordinator = HomeCoordinator(appState: appState)
        let exploreCoordinator = ExploreCoordinator(appState: appState)
        let profileCoordinator = ProfileCoordinator(appState: appState)

        // Wire settings callback for all tabs
        homeCoordinator.onSettingsTapped = { [weak self] in
            self?.appCoordinator?.presentSettings(
                from: homeCoordinator.navigationController
            )
        }
        exploreCoordinator.onSettingsTapped = { [weak self] in
            self?.appCoordinator?.presentSettings(
                from: exploreCoordinator.navigationController
            )
        }
        profileCoordinator.onSettingsTapped = { [weak self] in
            self?.appCoordinator?.presentSettings(
                from: profileCoordinator.navigationController
            )
        }

        // Wire deep link test on Explore tab
        exploreCoordinator.onDeepLinkTest = { [weak self] in
            self?.appCoordinator?.handleDeepLink(.itemDetail(Item.samples[0].id))
        }

        addChild(homeCoordinator)
        addChild(exploreCoordinator)
        addChild(profileCoordinator)

        homeCoordinator.start()
        exploreCoordinator.start()
        profileCoordinator.start()

        tabBarController.loadTabs(
            homeNav: homeCoordinator.navigationController,
            exploreNav: exploreCoordinator.navigationController,
            profileNav: profileCoordinator.navigationController
        )
    }

    deinit { print("[MainTabCoordinator] deinit") }
}
