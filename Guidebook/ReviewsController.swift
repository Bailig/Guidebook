//
//  ReviewsController.swift
//  Guidebook
//
//  Created by Bailig Abhanar on 2017-05-15.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import UIKit

class ReviewsController: UIViewController {

    var reviews = [Review]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    let cellId = "ReviewCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // dynamic row height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }


}

// MARK: - table view
extension ReviewsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let userNameLabel = cell.viewWithTag(1) as? UILabel, let textLabel = cell.viewWithTag(2) as? UILabel {
            userNameLabel.text = reviews[indexPath.row].userName
            textLabel.text = reviews[indexPath.row].text
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
