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
    var didSelectProfile:(() -> ())?
    @IBAction func profileButtonClick(_ sender: Any) {
        didSelectProfile!()
    }
    
    func configureHeader(profileName: String, email: String, imageName: String = "left_image_profile") {
        self.profileName.text! = profileName
        self.emailLabel.text! = email
        self.logoIcon.image = UIImage(named: imageName)
        logoIcon.layoutIfNeeded()
        logoIcon.layer.cornerRadius = logoIcon.frame.size.width/2
        logoIcon.clipsToBounds = true
    }
}
