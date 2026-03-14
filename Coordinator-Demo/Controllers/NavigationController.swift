//
//  NavigationController.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import UIKit

final class NavigationController: UINavigationController {
    init(rootViewController: UIViewController, isNavBarHidden: Bool) {
        super.init(rootViewController: rootViewController)
        self.isNavigationBarHidden = isNavBarHidden

        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.shadowImage = UIImage()
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.tintColor = .label
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
