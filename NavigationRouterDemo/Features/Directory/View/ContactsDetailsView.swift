//
//  ContactsDetailsView.swift
//  NavigationRouterDemo
//
//  Created by Yadu Madhavan on 05/04/26.
//

import SwiftUI

struct ContactsDetailsView: View {
    var id: String

    @State private var viewModel = ContactsDetailsViewModel()

    var body: some View {
        Text(viewModel.user?.title ?? "")
            .task {
                await viewModel.loadUser()
            }
    }
}
