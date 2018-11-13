//
//  Post.swift
//  Challenge
//
//  Created by Felix Changoo on 11/12/18.
//  Copyright © 2018 Felix Changoo. All rights reserved.
//

struct Post {
    let title: String
    let author: String
    let created: Int
    let thumbnail: String
    let num_comments: Int
}

extension Post {
    init(with json:[String: Any]) {
        title = json["title"] as! String
        author = json["author"] as! String
        created = json["created"] as! Int
        thumbnail = json["thumbnail"] as! String
        num_comments = json["num_comments"] as! Int
    }
}
