//
//  ContentView.swift
//  NavigationRouterDemo
//
//  Created by Yadu Madhavan on 04/04/26.
//

import CoreNav
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(SessionManager.self) private var sessionManager
    var body: some View {
        Group {
            switch sessionManager.appState {
            case .onBoarding:
                OnboardingView()
            case .login:
                LoginView()
            case .main:
                MainTabBar()
            }
        }
    }
}
