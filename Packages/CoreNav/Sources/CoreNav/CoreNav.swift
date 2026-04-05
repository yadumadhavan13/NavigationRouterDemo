// The Swift Programming Language
// https://docs.swift.org/swift-book

import Observation
import SwiftUI

public enum AppRoute: Hashable, Sendable {
    case settings
    case contacts
    case contactsDetails(id: String)
    case profile(id: String)
}

@MainActor
public protocol AppRouting: Sendable {
    func popToRoot()
    func navigate(to: AppRoute)
    func selectTab(_ tab: AppTab)
}

public enum AppState: Sendable {
    case onBoarding, login, main
}

// 2. The Silent Mock
@MainActor
public struct MockRouter: AppRouting {
    public nonisolated init() {}

    public func popToRoot() {
        print("Mock Router: Reset to Root requested.")
    }

    public func navigate(to: AppRoute) {
        print("Mock Router: Navigate to \(to) requested.")
    }

    public func selectTab(_ tab: AppTab) {
        print("selected Tab: \(tab)")
    }
}

// 3. The Native iOS 18 Dependency Injection
extension EnvironmentValues {
    @Entry public var appRouter: AppRouting = MockRouter()
}
