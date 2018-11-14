//
//  ViewController.swift
//  Challenge
//
//  Created by Felix Changoo on 11/12/18.
//  Copyright © 2018 Felix Changoo. All rights reserved.
//

import UIKit
import SDWebImage

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
        tableView.dataSource = self
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostTableViewCell else {
            fatalError("Cell not found!")
        }
        
        let cellViewModel = postListViewModel.getCellViewModel(at: indexPath)
        cell.titleLabel.text = cellViewModel.title
        cell.authorLabel.text = cellViewModel.author
        cell.numCommentsLabel.text = cellViewModel.numComments
        cell.timePassedLabel.text = cellViewModel.timePassed
        
        let url = URL(string: cellViewModel.thumbnail)
        if let url = url, url.isValidURL() {
            cell.imageView?.sd_setImage(with: URL(string: cellViewModel.thumbnail), completed: nil)
            cell.imageView?.clipsToBounds = true
            cell.imageView?.contentMode = .scaleAspectFit
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postListViewModel.totalNumberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

