//
//  NavigationRouterDemoApp.swift
//  NavigationRouterDemo
//
//  Created by Yadu Madhavan on 04/04/26.
//

import CoreNav
import SwiftData
import SwiftUI

@main
struct NavigationRouterDemoApp: App {
    @State private var sessionManager = SessionManager()

    @State private var router = Router()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.appRouter, router)
                .environment(router)
                .environment(sessionManager)
                // 🚀 Listen for incoming URLs (Universal Links or Custom Schemes)
                .onOpenURL { incomingURL in

                    // 1. Ensure the user is actually logged in before routing!
                    guard sessionManager.appState == .main else {
                        print("Ignored deep link: User is not logged in.")
                        return
                    }

                    // 2. Parse the URL into your enum
                    if incomingURL.host == "settings",
                       let id = incomingURL.pathComponents.last {
                        // 3. Fire the router!
                        router.handleDeepLink(.settings)
                    }
                }
        }
        .modelContainer(sharedModelContainer)
    }
}
