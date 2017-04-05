//
//  UBHomeViewController.swift
//  UbiqApp
//
//  Created by iOS Developer on 4/5/17.
//  Copyright © 2017 ubiq. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class UBHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func menuButtonClick(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
}
