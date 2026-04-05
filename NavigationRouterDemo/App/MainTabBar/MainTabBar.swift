//
//  MainTabBar.swift
//  NavigationRouterDemo
//
//  Created by Yadu Madhavan on 04/04/26.
//

import CoreNav
import SwiftUI

struct MainTabBar: View {
    // 1. Read the concrete Router from the SwiftUI Environment
    @Environment(Router.self) private var router

    /// body
    var body: some View {
        // 2. Safely create the Bindable wrapper RIGHT HERE.
        // SwiftUI guarantees the environment is fully loaded by the time `body` is called.
        @Bindable var bindableRouter = router
        // 3. Bind the TabView selection to the router's state
        TabView(selection: $bindableRouter.selectedTab) {
            // 🔄 Iterate through all cases in the AppTab enum dynamically
            ForEach(AppTab.allCases, id: \.self) { tab in
                // Bind to the custom subscript we made in the Router
                NavigationStack(path: $bindableRouter[pathFor: tab]) {
                    // 1. Resolve the target view
                    destinationView(for: tab)
                }
                // 2. Apply the dynamic icon helper
                .tabItem { tabLabel(for: tab) }
                // 3. Tag it with the enum case so the Router can select it
                .tag(tab)
            }
        }
    }

    // MARK: - View Routing Switchboard

    /// Maps the enum case to the actual SwiftUI Feature View
    @ViewBuilder
    private func destinationView(for tab: AppTab) -> some View {
        switch tab {
        case .recents:
            RecentsView()
        case .directory:
            DirectoryView()
        case .settings:
            SettingsView()
        }
    }

    // MARK: - Dynamic Icon Helper

    /// Resolves the correct filled/outline icon based on the active tab state
    @ViewBuilder
    private func tabLabel(for tab: AppTab) -> some View {
        let isActive = (router.selectedTab == tab)
        Label(
            tab.title,
            systemImage: isActive ? tab.selectedIcon : tab.defaultIcon
        )
    }
}
