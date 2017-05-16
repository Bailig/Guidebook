//
//  DetailController.swift
//  Guidebook
//
//  Created by Bailig Abhanar on 2017-05-15.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    var firebaseManager: FirebaseManager?
    var place: Place? {
        didSet {
            nameLabel.text = place?.name
            typeLabel.text = place?.type?.rawValue
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func shareButtonPressed(_ sender: UIButton) {
    }
    @IBAction func routeButtonPressed(_ sender: UIButton) {
    }
    @IBAction func faveButtonPressed(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setProperties(firebaseManager: FirebaseManager, place: Place) {
        self.firebaseManager = firebaseManager
        self.firebaseManager?.delegate = self
        self.firebaseManager?.fetchPlaceDetails(for: place)
    }
}


extension DetailController: FirebaseManagerDelegate {
    
    func firebaseManager(fetched placeWithDetail: Place) {
        place = placeWithDetail
    }
    
    func firebaseManager(fetched places: [Place]) { }
}
