//
//  UserModel.swift
//  NavigationRouterDemo
//
//  Created by Yadu Madhavan on 05/04/26.
//


struct UserModel: @nonisolated Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
