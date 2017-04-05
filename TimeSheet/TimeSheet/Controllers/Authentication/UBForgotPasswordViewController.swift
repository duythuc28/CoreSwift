//
//  UBForgotPasswordViewController.swift
//  UbiqApp
//
//  Created by iOS Developer on 4/4/17.
//  Copyright © 2017 ubiq. All rights reserved.
//

import UIKit

class UBForgotPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
