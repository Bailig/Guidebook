//
//  Review.swift
//  Guidebook
//
//  Created by Bailig Abhanar on 2017-05-20.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

struct Review {
    
    private(set) var userName: String?
    private(set) var text: String?
    private(set) var timestamp: String?
    
    init(userName: String, text: String) {
        self.userName = userName
        self.text = text
    }
    init(userName: String?, text: String?, timestamp: String?) {
        self.userName = userName
        self.text = text
        self.timestamp = timestamp
    }
}
