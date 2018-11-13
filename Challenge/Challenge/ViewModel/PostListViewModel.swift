//
//  PostListViewModel.swift
//  Challenge
//
//  Created by Felix Changoo on 11/13/18.
//  Copyright © 2018 Felix Changoo. All rights reserved.
//

import Foundation

class PostListViewModel {
    var apiService: APIServiceProtocol
    let redditEndpoint = "https://www.reddit.com/top/.json?count=50"
    
    private var posts: [Post] = [Post]()
    
    //Bindings
    var reloadTableViewClosure: (()->())?
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func getPosts() {
        let url = URL(string: redditEndpoint)!
        
        apiService.get(from: url) { [weak self] (data, error) in
            guard let strongSelf = self else { return }
            
            if let actualData = data {
                strongSelf.createPosts(data: actualData)
                print("posts looks like \(strongSelf.posts)")
            }
        }
    }
    
    private func createPosts(data: Data) {
        if let jsonDict = parsePostData(data: data),
        let dataDict = jsonDict["data"] as? [String: Any],
            let childrenDict = dataDict["children"] as? [[String: Any]] {
            
            childrenDict.forEach { (child) in
                let postDict = child["data"] as! [String: Any]
                let newPost = Post(with: postDict)
                self.posts.append(newPost)
            }
        }
    }
    
    private func parsePostData(data: Data) -> [String: Any]? {
        var jsonDict: [String: Any]?
        
        do {
            jsonDict = try JSONSerialization.jsonObject(with:
            data, options: []) as? [String: Any]
        } catch let parsingError {
            print("Error", parsingError)
        }
        
        return jsonDict
    }
    
}
