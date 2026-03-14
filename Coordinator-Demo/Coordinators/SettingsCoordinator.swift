//
//  SettingsCoordinator.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import UIKit
import SwiftUI

final class SettingsCoordinator: NSObject, Coordinator, UIAdaptivePresentationControllerDelegate {
    var navigationController: UINavigationController!
    var childCoordinators: [Coordinator] = []
    var isNavigating: Bool = false

    var onFinished: ((Coordinator) -> Void)?
    var onResetOnboarding: (() -> Void)?
    private let appState: AppState

    init(appState: AppState) {
        self.appState = appState
    }

    func start() {
        let settingsView = SettingsScreen(
            appState: appState,
            onDismiss: { [weak self] in
                self?.dismiss()
            },
            onDetailTapped: { [weak self] in
                self?.showSettingsDetail()
            },
            onResetOnboarding: { [weak self] in
                LocalStorage.shared.resetOnboarding()
                self?.navigationController.dismiss(animated: true) {
                    guard let self else { return }
                    self.onFinished?(self)
                    self.onResetOnboarding?()
                }
            }
        )

        let hostingController = UIHostingController(rootView: settingsView)
        hostingController.title = "Settings"

        navigationController = NavigationController(
            rootViewController: hostingController,
            isNavBarHidden: false
        )
    }

    private func showSettingsDetail() {
        navigateGuarded {
            let detailView = SettingsDetailScreen()
            let hostingController = UIHostingController(rootView: detailView)
            navigationController.pushViewController(hostingController, animated: true)
        }
    }

    func dismiss() {
        navigationController.dismiss(animated: true) { [weak self] in
            guard let self else { return }
            self.onFinished?(self)
        }
    }

    // MARK: - UIAdaptivePresentationControllerDelegate
    // Catches swipe-to-dismiss so we can clean up the child coordinator
    func presentationControllerDidDismiss(
        _ presentationController: UIPresentationController
    ) {
        onFinished?(self)
    }

    deinit { print("[SettingsCoordinator] deinit") }
}
