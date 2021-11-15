//
//  Friend.swift
//  client-server-IOS-applications
//
//  Created by LACKY on 24.10.2021.
//

import Foundation
import RealmSwift

// MARK: - Codable + SwiftyJSON

// MARK: - Item
class Friend: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var lastName: String
    @objc dynamic var photo50: String
    @objc dynamic var trackCode, firstName: String
    @objc dynamic var photo100: String
    @objc dynamic var deactivated: String?

    @objc dynamic var fullName: String {
        firstName + " " + lastName
    }

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case trackCode = "track_code"
        case firstName = "first_name"
        case photo100 = "photo_100"
        case deactivated
    }
}
