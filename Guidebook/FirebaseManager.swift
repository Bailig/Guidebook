//
//  FirebaseManager.swift
//  Guidebook
//
//  Created by Bailig Abhanar on 2017-05-15.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import Firebase

protocol FirebaseManagerDelegate: class {
    func firebaseManager(fetched places: [Place])
    func firebaseManager(fetched placeWithDetail: Place)
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
                self.delegate?.firebaseManager(fetched: self.places)
            }
        })
    }
    
    func fetchPlaceDetails(for place: Place) {
        guard let placeId = place.id else { return }
        
        ref.child("place-detail").child(placeId).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let placeDetail = snapshot.value as? [String: Any] else { return }
            
            place.setDetail(with: placeDetail)
            
            DispatchQueue.main.async {
                self.delegate?.firebaseManager(fetched: place)
            }
        })
    }
    
}
