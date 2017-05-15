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
}

class FirebaseManager {
    
    private var ref = FIRDatabase.database().reference()
    private var places = [Place]()
    
    weak var delegate: FirebaseManagerDelegate?
    
    func fetchPlaces() {
        ref.child("places").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let places = snapshot.value as? [String: Any] else { return }
            
            for (placeId, placeData) in places {
                if let placeData = placeData as? [String: Any] {
                    var place = Place(with: placeData)
                    place.id = placeId
                    self.places.append(place)
                }
            }
            DispatchQueue.main.async {
                self.delegate?.firebaseManager(fetchedPlaces: self.places)
            }
        })
    }
    
}
