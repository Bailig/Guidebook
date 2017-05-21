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
    var descriptionController: DescriptionController?
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
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let placeId = place?.id else { return }
        firebaseManager?.removeObservers(forPlaceId: placeId)
    }
    
    // MARK: - navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        currentController = segue.destination
        descriptionController = segue.destination as? DescriptionController
    }
    
    func moveToChildController(withIdentifier identifier: String) {
        
        var toController = storyboard?.instantiateViewController(withIdentifier: identifier)
        
        if identifier == "DescriptionController" {
            toController = descriptionController
        }
        
        if let toController = toController as? ReviewsController, let reviews = place?.reviews {
            toController.reviews = reviews
        }
        
        if let toController = toController as? WriteReviewController {
            toController.delegate = self
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
    
    func firebaseManager(fetchedPlaceWithDetail placeWithDetail: Place) {
        place = placeWithDetail
    }
    
    func firebaseManagerSetReviewError() {
        let alertController = UIAlertController(title: "Error", message: "There was an error saving your review", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func firebaseManagerSetReviewSuccess() {
        moveToChildController(withIdentifier: "ReviewsController")
    }
    func firebaseManager(fetchedPlaces places: [Place]) { }
}

// MARK: - write review controller
extension DetailController: WriteReviewControllerDelegate {
    func writeReview(setReview review: Review) {
        guard let placeId = place?.id else { return }
        firebaseManager?.setReview(review: review, forPlaceId: placeId)
    }
}
