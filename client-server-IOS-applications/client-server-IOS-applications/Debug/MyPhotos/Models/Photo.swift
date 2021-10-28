//
//  Photo.swift
//  client-server-IOS-applications
//
//  Created by LACKY on 25.10.2021.
//

import Foundation
import RealmSwift

// MARK: - PhotosJSON
struct PhotosJSON: Codable {
    let response: photosResponse
}

// MARK: - Response
struct photosResponse: Codable {
    let count: Int
    let items: [Photo]
}

// MARK: - Item
class Photo: Object, Codable {
    @objc dynamic var id: Int
    let comments: Comments
    let likes: Likes
    let reposts, tags: Comments
    @objc dynamic var date, ownerID, postID: Int
    @objc dynamic var text: String
    let sizes: [Size]
    @objc dynamic var hasTags: Bool
    @objc dynamic var albumID, canComment: Int

    enum CodingKeys: String, CodingKey {
        case id, comments, likes, reposts, tags, date
        case ownerID = "owner_id"
        case postID = "post_id"
        case text, sizes
        case hasTags = "has_tags"
        case albumID = "album_id"
        case canComment = "can_comment"
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}