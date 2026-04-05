//
//  Router.swift
//  NavigationRouterDemo
//
//  Created by Yadu Madhavan on 04/04/26.
//

import CoreNav
import Foundation
import Observation
import SwiftUI

@MainActor
@Observable
final class Router: AppRouting {
    // 1. Store all paths dynamically in a dictionary
    private var paths: [AppTab: NavigationPath] = [:]

    public var selectedTab: AppTab = .recents

    public init() {
        // Initialize an empty stack for every tab on launch
        for tab in AppTab.allCases {
            paths[tab] = NavigationPath()
        }
    }

    // 2. 🌟 The Subscript: Dynamically get/set the path for ANY tab.
    // This is what allows MainTabView to use a clean ForEach loop.
    public subscript(pathFor tab: AppTab) -> NavigationPath {
        get { paths[tab, default: NavigationPath()] }
        set { paths[tab] = newValue }
    }

    public func popToRoot() {
        // Dynamically clear all paths without needing to hardcode them
        for tab in AppTab.allCases {
            paths[tab] = NavigationPath()
        }
        selectedTab = .recents
    }

    func navigate(to: AppRoute) {
        // Append directly to the active tab's path
        paths[selectedTab]?.append(to)
    }

    func selectTab(_ tab: AppTab) {
        selectedTab = tab
    }

    // MARK: - The Magic Deep Link Handler

    public func handleDeepLink(_ target: DeepLinkTarget) {
        // 1. ALWAYS reset to root first.
        // If the user was already some screens deep in the tab.
        popToRoot()

        // 2. Route the user based on the target
        switch target {
        case .settings:
            // Switch the UI to the settings tab
            selectedTab = .settings
            // (No path append needed if Settings is the root of this tab)
        }
    }
}
