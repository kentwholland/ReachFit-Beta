//
//  MyFitnessViewController.swift
//  ReachFit Athlete
//
//  Created by Stefan DeClerck on 6/24/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit

class MyFitnessViewController: UIViewController {
    @IBOutlet weak var upcomingMyFitnessView: UIView!
    @IBOutlet weak var pastMyFitnessView: UIView!
    @IBOutlet weak var myFitnessSegmentController: UISegmentedControl!

    @IBAction func myFitnessSegmentControllerSelect(sender: UISegmentedControl) {
        
        switch myFitnessSegmentController.selectedSegmentIndex {
            
        case 0:
            upcomingMyFitnessView.hidden = false
            pastMyFitnessView.hidden = true
        case 1:
            upcomingMyFitnessView.hidden = true
            pastMyFitnessView.hidden = false
        default:
            break;
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myFitnessSegmentController.selectedSegmentIndex = 0;
        upcomingMyFitnessView.hidden = false
        pastMyFitnessView.hidden = true
        
    }

}
