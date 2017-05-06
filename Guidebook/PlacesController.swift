//
//  PlacesController.swift
//  Guidebook
//
//  Created by Bailig Abhanar on 2017-05-06.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import UIKit

class PlacesController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

// MARK: - table view
extension PlacesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
