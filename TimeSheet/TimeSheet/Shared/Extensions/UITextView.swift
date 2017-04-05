//
//  UITextView.swift
//  iOSSwiftCore
//
//  Created by Mobile on 6/20/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import UIKit

extension UITextView {

    // scale font
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let fontName = self.font!.fontName
        let fontSize = self.font!.pointSize
        self.font = UIFont(name: fontName, size: fontSize * CGFloat(Constants.FONT_SCALE_VALUE))
    }

    @IBInspectable var localizeKey: String {

        get {
            return ""
        } set {
            self.text = NSLocalizedString(newValue, comment: "")
        }
    }

    func isAllTextIsWhiteSpace() -> Bool {
        return text!.trimmingCharacters(in: .whitespaces).characters.count == 0
    }

    @IBInspectable var autoFontScale: Bool {
        get {
            return false
        }
        set (isScale) {
            if isScale {
                let newFontSize = font!.pointSize * (!isScale ? 1 : Constants.RATIO_WIDTH)
                self.font = UIFont(name: font!.fontName, size: newFontSize)
            }
        }
    }
}
