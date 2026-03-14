//
//  PrimaryTabController.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import UIKit

final class PrimaryTabController: UITabBarController {
    func loadTabs(
        homeNav: UINavigationController,
        exploreNav: UINavigationController,
        profileNav: UINavigationController
    ) {
        homeNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        exploreNav.tabBarItem = UITabBarItem(
            title: "Explore",
            image: UIImage(systemName: "safari"),
            tag: 1
        )
        profileNav.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.fill"),
            tag: 2
        )

        viewControllers = [homeNav, exploreNav, profileNav]
        tabBar.tintColor = .label
    }
}
