//
//  AppCoordinator.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import UIKit
import SwiftUI

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController!
    var isNavigating: Bool = false

    private let window: UIWindow
    let appState = AppState()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        if LocalStorage.shared.shouldShowOnboarding() {
            showOnboarding()
        } else {
            showMainApp()
        }
        window.makeKeyAndVisible()
    }

    func showOnboarding() {
        let onboardingView = OnboardingView { [weak self] in
            LocalStorage.shared.setOnboardingStatus(isComplete: true)
            self?.showMainApp()
        }
        window.rootViewController = UIHostingController(rootView: onboardingView)
    }

    func showMainApp() {
        let tabCoordinator = MainTabCoordinator(appState: appState)
        tabCoordinator.appCoordinator = self
        addChild(tabCoordinator)
        tabCoordinator.start()
        window.rootViewController = tabCoordinator.tabBarController
    }

    // MARK: - App-Wide Modal (Settings) with Child Coordinator Cleanup
    func presentSettings(from navigationController: UINavigationController) {
        navigateGuarded {
            let settingsCoordinator = SettingsCoordinator(appState: appState)
            addChild(settingsCoordinator)
            settingsCoordinator.start()

            // Memory leak prevention: remove child when dismissed
            settingsCoordinator.onFinished = { [weak self] coordinator in
                self?.removeChild(coordinator)
            }

            settingsCoordinator.onResetOnboarding = { [weak self] in
                self?.childCoordinators.removeAll()
                self?.showOnboarding()
            }

            let settingsNav = settingsCoordinator.navigationController!
            settingsNav.modalPresentationStyle = .pageSheet

            if let sheet = settingsNav.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.prefersGrabberVisible = true
            }

            // Wire up swipe-to-dismiss cleanup
            settingsNav.presentationController?.delegate = settingsCoordinator

            navigationController.present(settingsNav, animated: true)
        }
    }

    // MARK: - Deep Linking
    func handleDeepLink(_ deepLink: DeepLink) {
        showMainApp()

        guard let tabCoordinator = childCoordinators
            .compactMap({ $0 as? MainTabCoordinator }).first else { return }

        switch deepLink {
        case .itemDetail(let itemID):
            tabCoordinator.tabBarController.selectedIndex = 0

            let homeCoordinator = tabCoordinator.childCoordinators
                .compactMap { $0 as? HomeCoordinator }.first
            homeCoordinator?.navigationController.popToRootViewController(animated: false)
            homeCoordinator?.showDetail(for: itemID)

        case .settings:
            let activeNav = tabCoordinator.tabBarController.selectedViewController
                as? UINavigationController
            if let activeNav {
                presentSettings(from: activeNav)
            }
        }
    }

    deinit { print("[AppCoordinator] deinit") }
}
