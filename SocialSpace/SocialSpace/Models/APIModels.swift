//
//  APIModels.swift
//  SocialSpace
//
//  Created by Вадим Игнатенко on 16.03.25.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String?
    let username: String?
    let email: String?
}

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String?
    let body: String?
}
