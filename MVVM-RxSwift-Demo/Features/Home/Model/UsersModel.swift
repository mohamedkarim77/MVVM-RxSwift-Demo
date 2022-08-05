//
//  UsersModel.swift
//  MVVM-RxSwift-Demo
//
//  Created by Mohamed Abdelkarim on 05/08/2022.
//

import Foundation

// MARK: - Users
struct Users: Codable {
    let page, perPage, total, totalPages: Int?
    let data: [UserData]?
    let support: Support?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - UserData
struct UserData: Codable {
    let id: Int?
    let email, firstName, lastName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

// MARK: - Support
struct Support: Codable {
    let url: String?
    let text: String?
}
