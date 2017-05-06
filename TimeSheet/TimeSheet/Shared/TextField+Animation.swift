//
//  TextField+Animation.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/30/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import Foundation
import UIKit
import Material

class CustomTextField: TextField {
    override func prepare() {
        clipsToBounds = false
        borderStyle = .none
        backgroundColor = nil
        contentScaleFactor = Screen.scale
        font = RobotoFont.regular(with: 16)
        textColor = Color.darkText.primary
        
        prepareDivider()
        preparePlaceholderLabel()
        prepareDetailLabel()
        prepareTargetHandlers()
        prepareTextAlignment()
    }
}

extension CustomTextField {
    /// Prepares the divider.
    fileprivate func prepareDivider() {
        dividerColor = dividerNormalColor
    }
    
    /// Prepares the placeholderLabel.
    fileprivate func preparePlaceholderLabel() {
        placeholderNormalColor = Color.darkText.others
        placeholderLabel.backgroundColor = .clear
        addSubview(placeholderLabel)
    }
    
    /// Prepares the detailLabel.
    fileprivate func prepareDetailLabel() {
        detailLabel.font = RobotoFont.regular(with: 12)
        detailLabel.numberOfLines = 0
        detailColor = Color.darkText.others
        addSubview(detailLabel)
    }
    
    /// Prepares the leftView.
    fileprivate func prepareLeftView() {
        leftView?.contentMode = .left
        leftViewMode = .always
        updateLeftViewColor()
    }
    
    /// Prepares the target handlers.
    fileprivate func prepareTargetHandlers() {
        
        addTarget(self, action: #selector(handleTextEditingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(handleTextEditingChanged), for: .editingChanged)
        addTarget(self, action: #selector(handleTextEditingDidEnd), for: .editingDidEnd)
    }
    
    /// Prepares the textAlignment.
    fileprivate func prepareTextAlignment() {
        textAlignment = .rightToLeft == Application.userInterfaceLayoutDirection ? .right : .left
    }
}

extension TextField {
    /// Updates the leftView tint color.
    fileprivate func updateLeftViewColor() {
        leftView?.tintColor = isEditing ? leftViewActiveColor : leftViewNormalColor
    }
    
    /// Updates the placeholderLabel text color.
    fileprivate func updatePlaceholderLabelColor() {
        tintColor = placeholderActiveColor
        placeholderLabel.textColor = isEditing ? placeholderActiveColor : placeholderNormalColor
    }
    
    /// Updates the detailLabel text color.
    fileprivate func updateDetailLabelColor() {
        detailLabel.textColor = detailColor
    }
}

extension CustomTextField {
    /// Handles the text editing did begin state.
    @objc
    fileprivate func handleTextEditingDidBegin() {
        leftViewEditingBeginAnimation()
        if placeholderAnimation == TextFieldPlaceholderAnimation.default {
             placeholderEditingDidBeginAnimation()
        }
        dividerEditingDidBeginAnimation()
        
    }
    
    // Live updates the textField text.
    @objc
    fileprivate func handleTextEditingChanged(textField: UITextField) {
        if placeholderAnimation == TextFieldPlaceholderAnimation.hidden {
             placeholderEditingDidBeginAnimation()
        }
        (delegate as? TextFieldDelegate)?.textField?(textField: self, didChange: textField.text)
    }
    
    /// Handles the text editing did end state.
    @objc
    fileprivate func handleTextEditingDidEnd() {
        leftViewEditingEndAnimation()
        placeholderEditingDidEndAnimation()
        dividerEditingDidEndAnimation()
    }
    
    /// Handles the clearIconButton TouchUpInside event.
    @objc
    fileprivate func handleTextClearIconButton() {
        guard nil == delegate?.textFieldShouldClear || true == delegate?.textFieldShouldClear?(self) else {
            return
        }
        
        let t = text
        
        (delegate as? TextFieldDelegate)?.textField?(textField: self, willClear: t)
        
        text = nil
        
        (delegate as? TextFieldDelegate)?.textField?(textField: self, didClear: t)
    }
    
    /// Handles the visibilityIconButton TouchUpInside event.
    @objc
    fileprivate func handleTextVisibilityIconButton() {
        isSecureTextEntry = !isSecureTextEntry
        
        if !isSecureTextEntry {
            super.font = nil
            font = placeholderLabel.font
        }
        
        visibilityIconButton?.tintColor = visibilityIconButton?.tintColor.withAlphaComponent(isSecureTextEntry ? 0.38 : 0.54)
    }
}

extension CustomTextField {
    /// The animation for leftView when editing begins.
    fileprivate func leftViewEditingBeginAnimation() {
        updateLeftViewColor()
    }
    
    /// The animation for leftView when editing ends.
    fileprivate func leftViewEditingEndAnimation() {
        updateLeftViewColor()
    }
    
    /// The animation for the divider when editing begins.
    fileprivate func dividerEditingDidBeginAnimation() {
        dividerThickness = dividerActiveHeight
        dividerColor = dividerActiveColor
    }
    
    /// The animation for the divider when editing ends.
    fileprivate func dividerEditingDidEndAnimation() {
        dividerThickness = dividerNormalHeight
        dividerColor = dividerNormalColor
    }
    
    /// The animation for the placeholder when editing begins.
    fileprivate func placeholderEditingDidBeginAnimation() {
        guard .default == placeholderAnimation else {
            placeholderLabel.isHidden = true
            return
        }
        
        updatePlaceholderLabelColor()
        
        guard isPlaceholderAnimated else {
            return
        }
        
        guard isEmpty else {
            return
        }
        
        UIView.animate(withDuration: 0.15, animations: { [weak self] in
            guard let s = self else {
                return
            }
            
            s.placeholderLabel.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            
            switch s.textAlignment {
            case .left, .natural:
                s.placeholderLabel.frame.origin.x = s.leftViewWidth
            case .right:
                s.placeholderLabel.frame.origin.x = s.width - s.placeholderLabel.width
            default:break
            }
            
            s.placeholderLabel.frame.origin.y = -s.placeholderLabel.height + s.placeholderVerticalOffset
        })
    }
    
    /// The animation for the placeholder when editing ends.
    fileprivate func placeholderEditingDidEndAnimation() {
        guard .default == placeholderAnimation else {
            placeholderLabel.isHidden = !isEmpty
            return
        }
        
        updatePlaceholderLabelColor()
        
        guard isPlaceholderAnimated else {
            return
        }
        
        guard isEmpty else {
            return
        }
        
        UIView.animate(withDuration: 0.15, animations: { [weak self] in
            guard let s = self else {
                return
            }
            
            s.placeholderLabel.transform = CGAffineTransform.identity
            s.placeholderLabel.frame.origin.x = s.leftViewWidth
            s.placeholderLabel.frame.origin.y = 0
        })
    }
}
