//
//  ContactsDetailsViewModel.swift
//  NavigationRouterDemo
//
//  Created by Yadu Madhavan on 05/04/26.
//

import CoreNetwork
import Foundation
import Observation

@Observable
final class ContactsDetailsViewModel {
    private(set) var user: UserModel?
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?
    private(set) var client: APIClient

    init(client: APIClient = APIClient()) {
        self.client = client
    }

    func loadUser() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            user = try await fetchUser()
        } catch {
            errorMessage = "Failed to load user"
        }
    }

    private func fetchUser() async throws -> UserModel {
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        return try await client.request(url: url)
    }
}
