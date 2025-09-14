//
//  UserListModel.swift
//  UserDirectory
//
//  Created by Md. Faysal Ahmed on 14/9/25.
//

import Foundation

struct UserListModel: Decodable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let data: [User]
    
    enum CodingKeys: String, CodingKey {
        case page, total, data
        case perPage = "per_page"
        case totalPages = "total_pages"
    }
}

struct User: Decodable, Identifiable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id, email, avatar
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
