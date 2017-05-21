//
//  WriteReviewController.swift
//  Guidebook
//
//  Created by Bailig Abhanar on 2017-05-15.
//  Copyright © 2017 Bailig Abhanar. All rights reserved.
//

import UIKit

protocol WriteReviewControllerDelegate: class {
    func writeReview(setReview review: Review)
}

class WriteReviewController: UIViewController {

    weak var delegate: WriteReviewControllerDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty, let text = textView.text, !text.isEmpty else { return }
        
        let review = Review(userName: name, text: text)
        delegate?.writeReview(setReview: review)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
