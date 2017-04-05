//
//  NSLayoutConstraint.swift
//  Chantier
//
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {

    @IBInspectable var autoScale: Bool {
        get {
            return false
        }
        set (isScale) {
            if isScale {
                let newconstant = constant * (!isScale ? 1 : Constants.RATIO_WIDTH)
                constant = newconstant
            }
        }
    }
}
