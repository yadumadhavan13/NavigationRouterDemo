//
//  Router.swift
//  NavigationRouterDemo
//
//  Created by Yadu Madhavan on 04/04/26.
//

import CoreNav
import Observation
import Foundation
import SwiftUI

@MainActor
@Observable
final class Router: AppRouting {
    public var path: NavigationPath
    public var selectedTab: AppTab

    init(path: NavigationPath = NavigationPath(),
                selectedTab: AppTab = .home) {
        self.path = path
        self.selectedTab = selectedTab
    }

    func popToRoot() {
        path.removeLast(path.count)
    }

    func navigate(to: AppRoute) {
        path.append(to)
    }

    func selectTab(_ tab: AppTab) {
        selectedTab = tab
    }
}
