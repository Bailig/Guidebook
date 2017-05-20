//
//  Place.swift
//  Guidebook
//
//  Created by Bailig Abhanar on 2017-05-06.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

enum PlaceType: String {
    case Hotel = "Hotel"
    case Club = "Club"
    case Restaurant = "Restaurant"
    case Casino = "Casino"
    case Miscellaneous = "Miscellaneous"
}

class Place {
    
    var id: String?
    private(set) var name: String?
    private(set) var latitude: Double?
    private(set) var longitude: Double?
    private(set) var type: PlaceType?
    private(set) var description: String?
    private(set) var imageSmall: String?
    private(set) var imageBig: String?
    private(set) var reviews = [Review]()
    
    init(with dictionary: [String: Any]) {
        name = dictionary["name"] as? String
        latitude = dictionary["lat"] as? Double
        longitude = dictionary["long"] as? Double
        imageSmall = dictionary["imagesmall"] as? String
        
        if let typeFromDictionary = dictionary["type"] as? String {
            switch typeFromDictionary {
            case PlaceType.Hotel.rawValue:
                type = PlaceType.Hotel
            case PlaceType.Club.rawValue:
                type = PlaceType.Club
            case PlaceType.Restaurant.rawValue:
                type = PlaceType.Restaurant
            case PlaceType.Casino.rawValue:
                type = PlaceType.Casino
            case PlaceType.Miscellaneous.rawValue:
                type = PlaceType.Miscellaneous
            default:
                break
            }
        }
    }
    
    func setDetail(withDictionary dictionary: [String: Any]) {
        description = dictionary["desc"] as? String
        imageBig = dictionary["imagebig"] as? String
    }
    
    func addReview(withDictionary dictionary: [String: Any]) {
        let userName = dictionary["reviewer"] as? String
        let text = dictionary["review"] as? String
        let review = Review(userName: userName, text: text)
        reviews.append(review)
    }
}
