//
//  RecentsView.swift
//  NavigationRouterDemo
//
//  Created by Yadu Madhavan on 05/04/26.
//

import CoreNav
import SwiftUI

struct RecentsView: View {
    @Environment(\.appRouter) private var router

    var body: some View {
        Text("Recents")
        Button("Recents details") {
            // 3. Tell the router to do the heavy lifting
            router.navigate(to: .contactsDetails(id: "123"))
        }
        .navigationDestination(for: AppRoute.self) { handle(route: $0) }
    }

    // Update your deep routing switchboard
    @ViewBuilder
    private func handle(route: AppRoute) -> some View {
        switch route {
        case let .contactsDetails(id):
            ContactsDetailsView()
        default:
            Text("Oops! Invalid action")
        }
    }
}
