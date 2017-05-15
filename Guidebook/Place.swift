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

struct Place {
    
    var id: String?
    var name: String?
    var latitude: Double?
    var longitude: Double?
    var type: PlaceType?
    var imageSmall: String?
    
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
}
