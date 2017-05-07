//
//  UIViewController+Alert.swift
//  TimeSheet
//
//  Created by iOS Developer on 5/6/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, cancelTitle: String, otherButtonTitle: String?, otherAction: PopupDialogButton.PopupDialogButtonAction?) {
        let popup = PopupView.setup(title: title, message: message, cancelTitle: cancelTitle, otherButtonTitle: otherButtonTitle, otherAction: otherAction)
        self.present(popup, animated: true, completion: nil)
    }
}
