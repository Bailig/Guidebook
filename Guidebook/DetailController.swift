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
    var currentController: UIViewController?
    var place: Place? {
        didSet {
            nameLabel.text = place?.name
            typeLabel.text = place?.type?.rawValue
            if let descriptionController = currentController as? DescriptionController {
                descriptionController.setLabel(withText: place?.description)
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func shareButtonPressed(_ sender: UIButton) {
    }
    @IBAction func routeButtonPressed(_ sender: UIButton) {
    }
    @IBAction func faveButtonPressed(_ sender: UIButton) {
    }
    @IBAction func navButtonsTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            moveToChildController(withIdentifier: "DescriptionController")
        case 2:
            moveToChildController(withIdentifier: "ReviewsController")
        case 3:
            moveToChildController(withIdentifier: "WriteReviewController")
        default:
            moveToChildController(withIdentifier: "DescriptionController")
            break
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        currentController = segue.destination
    }
    
    private func moveToChildController(withIdentifier identifier: String) {
        let toController = storyboard?.instantiateViewController(withIdentifier: identifier)
        
        if let toController = toController as? ReviewsController, let reviews = place?.reviews {
            toController.reviews = reviews
        }
        
        if let toController = toController, let fromController = currentController {
            moveAndSizeChildControllers(fromController: fromController, toController: toController)
        }
    }
    
    private func moveAndSizeChildControllers(fromController: UIViewController, toController: UIViewController) {
        fromController.willMove(toParentViewController: nil)
        
        toController.view.frame = containerView.bounds
        
        addChildViewController(toController)
        containerView.addSubview(toController.view)
        
        // animatin
        toController.view.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            toController.view.alpha = 1
            fromController.view.alpha = 0
        }) { (completed) in
            fromController.view.removeFromSuperview()
            fromController.removeFromParentViewController()
            
            toController.didMove(toParentViewController: self)
            self.currentController = toController
        }
    }
    
    // MARK: - set properties
    func setProperties(firebaseManager: FirebaseManager, place: Place) {
        self.firebaseManager = firebaseManager
        self.firebaseManager?.delegate = self
        self.firebaseManager?.fetchPlaceDetails(forPlace: place)
    }
}

// MARK: - firebase manager
extension DetailController: FirebaseManagerDelegate {
    
    func firebaseManager(fetched placeWithDetail: Place) {
        place = placeWithDetail
    }
    
    func firebaseManager(fetched places: [Place]) { }
}
