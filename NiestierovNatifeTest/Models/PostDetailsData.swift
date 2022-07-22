//
//  PostDetailsData.swift
//  NiestierovNatifeTest
//
//  Created by Denys Niestierov on 22.07.2022.
//

import Foundation

// MARK: - PostDetailsData -
struct PostDetailsData: Codable {
    let post: Post
}

// MARK: - Post -
struct Post: Codable {
    let postId: Int
    let timeshamp: TimeInterval
    let title: String
    let text: String
    let postImage: String
    let likes_count: Int
}
