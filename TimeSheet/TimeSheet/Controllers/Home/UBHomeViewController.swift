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
        // Do any additional setup after loading the view.
        self.title = "HOME"
    }
    
    @IBAction func menuButtonClick(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
}
