//
//  FindViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit

class FindViewController: UIViewController {
    
    @IBOutlet weak var mapFindView: UIView!
    @IBOutlet weak var searchFindView: UIView!
    @IBOutlet weak var findSegmentController: UISegmentedControl!
    
    @IBAction func findSegmentControllerSelect(sender: UISegmentedControl) {
        
        switch findSegmentController.selectedSegmentIndex {
            
        case 0:
            mapFindView.hidden = true
            searchFindView.hidden = false
            
        case 1:
            mapFindView.hidden = false
            searchFindView.hidden = true
            
        default:
            break
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        findSegmentController.selectedSegmentIndex = 0
        mapFindView.hidden = true
        searchFindView.hidden = false
        
    }
    
}
