//
//  Utilities.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/7/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//
import UIKit

final class Utilities {
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func isValidPassword(password: String) -> Bool {
        return true
    }
}
