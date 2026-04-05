//
//  SessionManager.swift
//  CoreNav
//
//  Created by Yadu Madhavan on 05/04/26.
//

import Foundation
import Observation

@MainActor
@Observable
public class SessionManager {
    public var appState: AppState

    public init(appState: AppState = .onBoarding) {
        self.appState = appState
    }

    public func logIn() {
        appState = .main
    }

    public func logOut() {
        appState = .login
    }
}
