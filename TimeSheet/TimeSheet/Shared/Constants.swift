//
//  Constants.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/2/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//
import UIKit

struct APIConstant {
    #if DEVELOPMENT
    static let BASE_URL = "http://dev.server.com/api/"
    #else
    static let BASE_URL = "http://prod.server.com/api/"
    #endif
}

let UIAppDelegate                   = UIApplication.shared.delegate as! AppDelegate
