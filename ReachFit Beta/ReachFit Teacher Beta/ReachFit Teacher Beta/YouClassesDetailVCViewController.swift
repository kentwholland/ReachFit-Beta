//
//  YouClassesDetailVCViewController.swift
//  ReachFit Beta
//
//  Created by Stefan DeClerck on 6/11/15.
//  Copyright (c) 2015 ReachFit. All rights reserved.
//

import UIKit

var classFullNameLabelSubscribed: String = "test"
var classTopicLabelSubscribed: String = "test"
var instructorLabelSubscribed: String = "test"
var classDateLabelSubscribed: String = "test"
var classDescriptionLabelSubscribed: String = "test"

class YouClassesDetailVCViewController: UIViewController {

    @IBOutlet weak var classFullNameLabel: UILabel!
    @IBOutlet weak var classInstructorLabel: UILabel!
    @IBOutlet weak var classTopicLabel: UILabel!
    @IBOutlet weak var classDateLabel: UILabel!
    @IBOutlet weak var classDescriptionLabel: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        updateLabels()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
//         Do any additional setup after loading the view.
    }
    
    func updateLabels() {
        classFullNameLabel.text = classFullNameLabelSubscribed
        classInstructorLabel.text = instructorLabelSubscribed
        classTopicLabel.text = classTopicLabelSubscribed
        classDateLabel.text = classDateLabelSubscribed
        classDescriptionLabel.text = classDescriptionLabelSubscribed
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
//         Dispose of any resources that can be recreated.
    }

}
