//
//  LoginView.swift
//  NavigationRouterDemo
//
//  Created by Yadu Madhavan on 04/04/26.
//

import CoreNav
import SwiftUI

struct LoginView: View {
    @Environment(SessionManager.self) private var sessionManager

    var body: some View {
        Button("Authenticated") {
            sessionManager.appState = .main
        }
    }
}
