//
//  HomeCoordinator.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import UIKit
import SwiftUI

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController!
    var childCoordinators: [Coordinator] = []
    var isNavigating: Bool = false

    var onSettingsTapped: (() -> Void)?
    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    func start() {
        let homeView = HomeScreen(
            appState: appState,
            onSettingsTapped: { [weak self] in
                self?.onSettingsTapped?()
            },
            onItemSelected: { [weak self] item in
                self?.showDetail(for: item)
            }
        )

        let hostingController = UIHostingController(rootView: homeView)
        hostingController.title = "Home"

        navigationController = NavigationController(
            rootViewController: hostingController,
            isNavBarHidden: false
        )
    }

    func showDetail(for item: Item) {
        navigateGuarded {
            let detailView = ItemDetailScreen(item: item, appState: appState)
            let hostingController = UIHostingController(rootView: detailView)
            navigationController.pushViewController(hostingController, animated: true)
        }
    }

    /// Deep link variant — find item by ID from sample data
    func showDetail(for itemID: UUID) {
        if let item = Item.samples.first(where: { $0.id == itemID }) {
            showDetail(for: item)
        }
    }

    deinit { print("[HomeCoordinator] deinit") }
}
