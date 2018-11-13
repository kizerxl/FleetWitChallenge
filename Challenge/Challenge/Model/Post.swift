//
//  Post.swift
//  Challenge
//
//  Created by Felix Changoo on 11/12/18.
//  Copyright © 2018 Felix Changoo. All rights reserved.
//

struct Posts: Codable {
    let posts: [Post]
}

struct Post: Codable {
    let title: String
    let author: String
    let created: Int
    let thumbnail: String
    let num_comments: Int
}
