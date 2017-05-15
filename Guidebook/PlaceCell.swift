//
//  PlaceCell.swift
//  Guidebook
//
//  Created by Bailig Abhanar on 2017-05-15.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {
    
    var place: Place? {
        didSet {
            typeLabel.text = place?.type?.rawValue
            nameLabel.text = place?.name
        }
    }
 
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
