//
//  Cached.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/2/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import UIKit

class Cached {
    
    static let userDefaults = UserDefaults.standard
    
    static var token: String {
        get {
            return userDefaults.object(forKey: "TOKEN") as? String ?? ""
        }
        set(newToken) {
            userDefaults.set(newToken, forKey: "TOKEN")
        }
    }
    
    static func setDefaults(object: Any, forKey: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        userDefaults.set(data, forKey: forKey)
    }
    
    static func object(forKey: String) -> Any? {
        if let data = userDefaults.object(forKey: forKey) as? NSData {
            return NSKeyedUnarchiver.unarchiveObject(with: data as Data) ?? nil
        }
        return nil
    }
    
    static func removeObject(forKey: String) {
        userDefaults.removeObject(forKey: forKey)
    }
}
