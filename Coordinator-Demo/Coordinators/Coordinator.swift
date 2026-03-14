//
//  Coordinator.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController! { get set }
    var isNavigating: Bool { get set }
    func start()
}

extension Coordinator {
    func addChild(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }

    func navigateGuarded(unlockAfter: TimeInterval = 0.5, action: () -> Void) {
        guard !isNavigating else { return }
        isNavigating = true
        action()
        DispatchQueue.main.asyncAfter(deadline: .now() + unlockAfter) { [weak self] in
            self?.isNavigating = false
        }
    }
}
