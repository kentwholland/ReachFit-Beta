//
//  SearchDetailViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/27/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {

    var viewControllerTitle: String = "Class"
    
    @IBAction func addOrRemoveFromClasses(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println("\(viewControllerTitle)")
        
        self.navigationItem.title = viewControllerTitle
        
    }

}
