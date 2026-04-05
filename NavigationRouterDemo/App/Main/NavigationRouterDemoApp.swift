//
//  NavigationRouterDemoApp.swift
//  NavigationRouterDemo
//
//  Created by Yadu Madhavan on 04/04/26.
//

import CoreNav
import SwiftUI
import SwiftData

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
                .environment(sessionManager)
        }
        .modelContainer(sharedModelContainer)
    }
}
