//
//  Photo.swift
//  client-server-IOS-applications
//
//  Created by LACKY on 25.10.2021.
//

import Foundation

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
struct Photo: Codable {
    let id: Int
    let comments: Comments
    let likes: Likes
    let reposts, tags: Comments
    let date, ownerID, postID: Int
    let text: String
    let sizes: [Size]
    let hasTags: Bool
    let albumID, canComment: Int

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
