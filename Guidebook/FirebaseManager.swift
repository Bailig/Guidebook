//
//  FirebaseManager.swift
//  Guidebook
//
//  Created by Bailig Abhanar on 2017-05-15.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import Firebase

protocol FirebaseManagerDelegate: class {
    func firebaseManager(fetchedPlaces places: [Place])
    func firebaseManager(fetchedPlaceWithDetail placeWithDetail: Place)
    func firebaseManagerSetReviewError()
    func firebaseManagerSetReviewSuccess()
}

class FirebaseManager {
    
    private var ref = FIRDatabase.database().reference()
    private var places = [Place]()
    
    var delegate: FirebaseManagerDelegate?
    
    func fetchPlaces() {
        ref.child("places").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let places = snapshot.value as? [String: Any] else { return }
            
            for (placeId, placeData) in places {
                if let placeData = placeData as? [String: Any] {
                    let place = Place(with: placeData)
                    place.id = placeId
                    self.places.append(place)
                }
            }
            DispatchQueue.main.async {
                self.delegate?.firebaseManager(fetchedPlaces: self.places)
            }
        })
    }
    
    func fetchPlaceDetails(forPlace place: Place) {
        guard let placeId = place.id else { return }
        
        ref.child("place-detail").child(placeId).observe(.value, with: { (snapshot) in
            guard let placeDetail = snapshot.value as? [String: Any] else { return }
            
            place.setDetail(withDictionary: placeDetail)
            
            if let reviews = placeDetail["reviews"] as? [String: Any] {
                place.reviews.removeAll()
                for (_, reviewData) in reviews {
                    if let review = reviewData as? [String : Any] {
                        place.addReview(withDictionary: review)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.delegate?.firebaseManager(fetchedPlaceWithDetail: place)
            }
        })
        
    }
    
    func setReview(review: Review, forPlaceId placeId: String) {
        let reviewDictionary = ["review": review.text, "reviewer": review.userName, "timestamp": String(describing: Date())]
        ref.child("place-detail").child(placeId).child("reviews").childByAutoId().setValue(reviewDictionary) { (error, ref) in
            if let error = error {
                print("error: \(error.localizedDescription)")
                self.delegate?.firebaseManagerSetReviewError()
                return
            }
            self.delegate?.firebaseManagerSetReviewSuccess()
        }
    }
    
    func removeObservers(forPlaceId placeId: String) {
        ref.child("place-detail").child(placeId).removeAllObservers()
    }
}
