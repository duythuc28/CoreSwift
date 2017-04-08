//
//  UBContainerViewController.swift
//  UbiqApp
//
//  Created by iOS Developer on 4/5/17.
//  Copyright © 2017 ubiq. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class UBContainerViewController: SlideMenuController {
    override func awakeFromNib() {
        if let controller = UIStoryboard(name: Storyboards.home, bundle: nil).instantiateViewController(withIdentifier: ControllerIdentifier.home) as? UBHomeViewController {
            let homeNavigationController:UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: ControllerIdentifier.homeNavigationController) as! UINavigationController
            homeNavigationController.viewControllers = [controller]
            self.mainViewController = homeNavigationController
        }
        if let controller = UIStoryboard(name: Storyboards.home, bundle: nil).instantiateViewController(withIdentifier: ControllerIdentifier.leftMenu) as? TSLeftMenuViewController {
            self.leftViewController = controller
        }
        super.awakeFromNib()
    }
}
