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
    
    private var tableViewModels: [PostTableViewModel] = [PostTableViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var totalNumberOfCells: Int {
        return tableViewModels.count
    }
    
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
                let posts = strongSelf.createPosts(data: actualData)
                let postTableViewModels = posts.map { strongSelf.createTableViewModel(post: $0) }
                
                strongSelf.posts = posts
                strongSelf.tableViewModels = postTableViewModels
            }
        }
    }
    
    private func createPosts(data: Data) -> [Post] {
        var posts = [Post]()
        
        if let jsonDict = parsePostData(data: data),
        let dataDict = jsonDict["data"] as? [String: Any],
            let childrenDict = dataDict["children"] as? [[String: Any]] {
            
            childrenDict.forEach { (child) in
                let postDict = child["data"] as! [String: Any]
                let newPost = Post(with: postDict)
                posts.append(newPost)
            }
        }
        return posts
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
    
    func getCellViewModel(at indexPath: IndexPath) -> PostTableViewModel {
        return tableViewModels[indexPath.row]
    }
    
    private func createTableViewModel(post: Post) -> PostTableViewModel {
        return PostTableViewModel(post: post)
    }
    
}
