//
//  SHRxswift_1ViewController.swift
//  RxSwiftDemo2019_03_31
//
//  Created by rrd on 2019/6/17.
//  Copyright © 2019 远平. All rights reserved.
//

import UIKit

class SHRxswift_1ViewController: UIViewController {

    @IBOutlet weak var greenViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize = UIScreen.main.bounds
        if screenSize.width == 320 && screenSize.height == 480 {
            greenViewTopConstraint.constant = 50
        }
        else if screenSize.width == 320 && screenSize.height == 568 {
            greenViewTopConstraint.constant = 100
        }
        else if screenSize.width == 375 && screenSize.height == 667 {
            greenViewTopConstraint.constant = 150
        }
        else if screenSize.width == 414 && screenSize.height == 736 {
            greenViewTopConstraint.constant = 200
        }
        else if screenSize.width == 375 && screenSize.height == 812 {
            greenViewTopConstraint.constant = 250
        }
        else if screenSize.width == 414 && screenSize.height == 896 {
            greenViewTopConstraint.constant = 300
        }
        
        // Do any additional setup after loading the view.
    }

}
