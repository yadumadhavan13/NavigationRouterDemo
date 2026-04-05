//
//  DirectoryView.swift
//  NavigationRouterDemo
//
//  Created by Yadu Madhavan on 05/04/26.
//

import CoreNav
import SwiftUI

struct DirectoryView: View {
    @Environment(\.appRouter) private var router

    /// body
    var body: some View {
        Text("Directory")
        Button("Contacts details") {
            // router handles the actions for contact details navigation.
            router.navigate(to: .contactsDetails(id: "123"))
        }
        .navigationDestination(for: AppRoute.self) { handle(route: $0) }
    }

    /// Handle the router actions for DirectoryView.
    @ViewBuilder
    private func handle(route: AppRoute) -> some View {
        switch route {
        case let .contactsDetails(id):
            ContactsDetailsView(id: id)
        default:
            Text("Oops! Invalid action")
        }
    }
}
