//
//  DescriptionController.swift
//  Guidebook
//
//  Created by Bailig Abhanar on 2017-05-15.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import UIKit

class DescriptionController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setLabel(withText text: String?) {
        label.text = text
    }
}

