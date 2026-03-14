//
//  Item.swift
//  Coordinator-Demo
//
//  Created by Gavin Shrader on 3/14/26.
//

import Foundation

struct Item: Identifiable, Hashable {
    let id: UUID
    let title: String
    let subtitle: String
    let iconName: String // SF Symbol name

    static let samples: [Item] = [
        Item(id: UUID(), title: "Getting Started", subtitle: "Learn the basics of coordinators", iconName: "book.fill"),
        Item(id: UUID(), title: "Navigation Patterns", subtitle: "Push, present, and deep link", iconName: "arrow.triangle.branch"),
        Item(id: UUID(), title: "Data Flow", subtitle: "Observable state and closures", iconName: "arrow.left.arrow.right"),
        Item(id: UUID(), title: "Memory Management", subtitle: "Avoiding retain cycles", iconName: "memorychip"),
        Item(id: UUID(), title: "SwiftUI Integration", subtitle: "UIHostingController best practices", iconName: "swift"),
        Item(id: UUID(), title: "Tab Bar Setup", subtitle: "Multi-tab coordinator hierarchy", iconName: "rectangle.split.3x1.fill"),
    ]
}
