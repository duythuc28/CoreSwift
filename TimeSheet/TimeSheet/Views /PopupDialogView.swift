//
//  PopupDialogView.swift
//  TimeSheet
//
//  Created by iOS Developer on 5/6/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import Foundation
import UIKit

final class PopupView {
    static func setup(title: String,
                     message: String,
                     cancelTitle: String,
                     otherButtonTitle: String? = nil,
                     otherAction: PopupDialogButton.PopupDialogButtonAction? = nil) -> PopupDialog {
        self.defaultPopup()
        let alertViewController = TSPopupViewController(title: title, message: message)
        // Create the dialog
        let popup = PopupDialog(viewController: alertViewController, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        let cancelButton = CancelButton(title: cancelTitle, height: 45, dismissOnTap: true, action: nil)
        cancelButton.separatorColor = UIColor.clear
        cancelButton.buttonColor = UIColor.blue
        cancelButton.titleColor = UIColor.white
        popup.addButton(cancelButton)
        
        // Create second button
        if let buttonTitle = otherButtonTitle {
            let otherButton = DefaultButton(title: buttonTitle, height: 45, dismissOnTap: true, action: otherAction)
            otherButton.separatorColor = UIColor.clear
            otherButton.buttonColor = UIColor.blue
            otherButton.leftSeparatorColor = UIColor.white
            otherButton.needsLeftSeparator = true
            otherButton.titleColor = UIColor.white
            popup.addButton(otherButton)
        }
        return popup
    }
    
    fileprivate static func defaultPopup() {
        let pcv = PopupDialogContainerView.appearance()
        pcv.popupCornerRadius    = 0
        let ov = PopupDialogOverlayView.appearance()
        ov.popupOpacity     = 0.7
        ov.color       = UIColor.black
        ov.blurEnabled = false
    }
    
}
