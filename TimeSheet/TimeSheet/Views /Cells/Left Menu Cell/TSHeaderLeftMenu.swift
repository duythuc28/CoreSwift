//
//  TSHeaderLeftMenu.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/8/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import UIKit

class TSHeaderLeftMenu: UIView {
    @IBOutlet weak var logoIcon: UIImageView! {
        didSet {
//            logoIcon.layoutIfNeeded()
//            logoIcon.layer.cornerRadius = logoIcon.frame.size.width/2
//            logoIcon.clipsToBounds = true
        }
    }
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBAction func profileButtonClick(_ sender: Any) {
        print("Profile picture click")
    }
}
