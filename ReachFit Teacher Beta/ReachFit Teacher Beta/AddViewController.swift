//
//  AddViewController.swift
//  ReachFit Teacher Beta
//
//  Created by Stefan DeClerck on 6/16/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit
import Parse

class AddViewController: UIViewController {

    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var workoutTypeTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
     
    @IBAction func done(sender: AnyObject) {
        
    }
    
    override func viewDidAppear(animated: Bool) {
        var frameRect: CGRect = descriptionTextField.frame;
        frameRect.size.height = 53;
        descriptionTextField.frame = frameRect;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
