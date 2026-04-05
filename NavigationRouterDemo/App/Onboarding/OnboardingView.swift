//
//  Onboarding.swift
//  NavigationRouterDemo
//
//  Created by Yadu Madhavan on 04/04/26.
//

import CoreNav
import SwiftUI

struct OnboardingView: View {
    @Environment(SessionManager.self) private var sessionManager

    var body: some View {
        Button("Onboarded") {
            sessionManager.appState = .login
        }
    }
}
