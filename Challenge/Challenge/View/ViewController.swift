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
        
        setupView()
        initViewModel()
    }
    
    func setupView() {
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func initViewModel() {
        postListViewModel = PostListViewModel(apiService: apiService)
        
        //setup bindings here
        postListViewModel.reloadTableViewClosure = { [weak self] in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
        
        postListViewModel.getPosts()
    }


}

