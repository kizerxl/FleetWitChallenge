//
//  ViewController.swift
//  Challenge
//
//  Created by Felix Changoo on 11/12/18.
//  Copyright © 2018 Felix Changoo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let apiService = ApiService(session: URLSession.shared)
    var postListViewModel: PostListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func initViewModel() {
        postListViewModel = PostListViewModel(apiService: apiService)
        postListViewModel.getPosts()
        
        //setup bindings here
    }


}

