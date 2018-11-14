//
//  PostTableViewModel.swift
//  Challenge
//
//  Created by Felix Changoo on 11/13/18.
//  Copyright © 2018 Felix Changoo. All rights reserved.
//

struct PostTableViewModel {
    let title: String
    let author: String
    let timePassed: String
    let numComments: String
    let thumbnail: String
}

extension PostTableViewModel {
    init(post: Post) {
        title = post.title
        author = post.author
        numComments = "\(post.numOfComments) comments"
        thumbnail = post.thumbnail
        timePassed = post.created.getElapsedTimeReadout()
    }
}
