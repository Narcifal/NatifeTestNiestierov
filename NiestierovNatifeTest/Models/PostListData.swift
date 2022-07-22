//
//  PostListData.swift
//  NiestierovNatifeTest
//
//  Created by Denys Niestierov on 22.07.2022.
//

import Foundation

//MARK: - PostListData -
struct PostListData: Codable {
    var posts: [Posts]
}

//MARK: - Posts -
struct Posts: Codable {
    let postId: Int
    var timeshamp: TimeInterval
    let title: String
    let preview_text: String
    var likes_count: Int
}
