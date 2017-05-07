//
//  TSPopupViewController.swift
//  TimeSheet
//
//  Created by iOS Developer on 5/6/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import UIKit

class TSPopupViewController: UIViewController {

    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var messageLabel: UILabel!
    
    open var alertTitle: String = ""
    open var messageTitle: String = ""
    
    init(title: String, message: String) {
        super.init(nibName: "TSPopupViewController", bundle: nil)
        self.alertTitle = title
        self.messageTitle = message
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = alertTitle
        messageLabel.text = messageTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
