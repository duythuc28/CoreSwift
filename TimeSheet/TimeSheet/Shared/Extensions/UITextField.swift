//
//  UITextField.swift
//  iOSSwiftCore
//
//  Created by Imac on 6/16/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import UIKit

private var maxLengths = [UITextField: Int]()

extension UITextField {
 
    // scale font
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let fontName = self.font!.fontName
        let fontSize = self.font!.pointSize
        self.font = UIFont(name: fontName, size: fontSize * CGFloat(Constants.FONT_SCALE_VALUE))
      
        //  Set padding view
//        self.setPaddingView()

      
    }
    
    @IBInspectable var autoFontScale: Bool {
        get {
            return false
        }
        set (isScale) {
            if isScale {
                let newFontSize = self.font!.pointSize * (!isScale ? 1 : (ScreenSize.SCREEN_WIDTH / 414))
                self.font = UIFont(name: self.font!.fontName, size: newFontSize)
            }
        }
    }
    
    @IBInspectable var localizeKey: String {
        
        get {
            return ""
        } set {
            self.text = NSLocalizedString(newValue, comment: "")
        }
    }
    
    @IBInspectable var placeholderLocalizeKey: String {
        
        get {
            return ""
        } set {
            self.placeholder = NSLocalizedString(newValue, comment: "")
        }
    }
  
  @IBInspectable var placeHolderColor: UIColor? {
    get {
      return self.placeHolderColor
    }
    set {
      self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSForegroundColorAttributeName: newValue!])
    }
    
  }
  
  
  @IBInspectable var maxLength: Int {
    get {
      
      guard let length = maxLengths[self] else {
        return Int.max
      }
      return length
    }
    set {
      maxLengths[self] = newValue
      
        addTarget(
            self,
            action: #selector(limitLength),
            for: UIControlEvents.editingChanged
      )
    }
  }
    
    @IBInspectable var padding: CGFloat {
        get {
            
           return 0
        }
        set {
            setPaddingView(padding: newValue)
        }
    }
  
  func limitLength(textField: UITextField) {
    
    guard let prospectiveText = textField.text, prospectiveText.characters.count > maxLength else {
        return
    }
    
    let selection = selectedTextRange
    text = prospectiveText.substring(with:(prospectiveText.startIndex..<prospectiveText.index(prospectiveText.startIndex, offsetBy: 0)))
    selectedTextRange = selection
  }
  
  
    func setPaddingView(padding : CGFloat) {
    // Make padding for text field
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
    self.leftView = paddingView
    self.leftViewMode = .always
    self.rightView = paddingView
    self.rightViewMode = .always
  }
  
  
}
