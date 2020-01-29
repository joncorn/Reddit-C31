//
//  JDCPostListTableViewController.swift
//  Reddit-C31
//
//  Created by Jon Corn on 1/29/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
//

import UIKit

class JDCPostListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JDCPostController.shared().fetchPosts { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("post was empty")
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JDCPostController.shared().posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? JDCPostTableViewCell else { return UITableViewCell() }
        
        let post = JDCPostController.shared().posts[indexPath.row]
        cell.titleLabel.text = post.title
//        cell.postImageView.image = nil
        JDCPostController.shared().fetchImage(forPosts: post) { (image) in
            DispatchQueue.main.async {
                cell.postImageView.image = image
            }
        }
        
        return cell
    }
}
