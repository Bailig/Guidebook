//
//  PlacesController.swift
//  Guidebook
//
//  Created by Bailig Abhanar on 2017-05-06.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import UIKit

class PlacesController: UIViewController {

    var firebaseManager: FirebaseManager?
    var places = [Place]()
    let cellId = "PlaceCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(PlaceCell.self, forCellReuseIdentifier: cellId)
        
        firebaseManager = FirebaseManager()
        firebaseManager?.delegate = self
        firebaseManager?.fetchPlaces()
    }
    
}

// MARK: - firebase manager
extension PlacesController: FirebaseManagerDelegate {
    func firebaseManager(fetchedPlaces places: [Place]) {
        self.places = places
        tableView.reloadData()
    }
}

// MARK: - table view
extension PlacesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? PlaceCell else {
            print("error: unable to dequeue reusable cell with id \(cellId)")
            return UITableViewCell()
        }
        
        cell.place = places[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
