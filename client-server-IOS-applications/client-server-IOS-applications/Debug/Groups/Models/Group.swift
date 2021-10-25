//
//  Group.swift
//  client-server-IOS-applications
//
//  Created by LACKY on 25.10.2021.
//

import Foundation

// MARK: - GroupsJSON
struct GroupsJSON: Codable {
    let response: groupsResponse
}

// MARK: - Response
struct groupsResponse: Codable {
    let count: Int
    let items: [Group]
}

// MARK: - Item
struct Group: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type: TypeEnum
    let screenName, name: String
    let isClosed: Int

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

enum TypeEnum: String, Codable {
    case group = "group"
    case page = "page"
}
