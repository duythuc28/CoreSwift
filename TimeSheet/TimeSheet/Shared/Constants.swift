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
    static let BASE_URL = "http://demo9490743.mockable.io"
    #else
    static let BASE_URL = "http://prod.server.com/api"
    #endif
}

let UIAppDelegate                   = UIApplication.shared.delegate as! AppDelegate

struct Storyboards {
    static let home = "Home"
    static let main = "Main"
    static let authentication = "Authentication"
    static let userProfile = "UserProfile"
    static let timesheet = "TimeSheet"
    static let checkIn = "CheckIn"
}

struct ControllerIdentifier {
    static let home = "UBHomeViewController"
    static let leftMenu = "TSLeftMenuViewController"
    static let login = "UBLoginViewController"
    static let homeNavigationController = "UBNavigationHomeViewController"
    static let container = "UBContainerViewController"
}

struct CellIdentifier {
    static let leftMenu = "leftMenuCell"
}

struct NibName {
    static let leftMenuCell = "TSLeftMenuCell"
    static let leftMenuHeader = "TSHeaderLeftMenu"
}
