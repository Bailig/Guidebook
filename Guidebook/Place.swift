//
//  Place.swift
//  Guidebook
//
//  Created by Bailig Abhanar on 2017-05-06.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

enum PlaceType {
    case Hotel
    case Club
    case Restaurant
    case Casino
    case Miscellaneous
}
struct Place {
    
    var id: String?
    var name: String?
    var description: String?
    var latitude: Double?
    var longitude: Double?
    var type: PlaceType?
}
