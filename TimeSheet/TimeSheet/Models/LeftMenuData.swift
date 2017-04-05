//
//  LeftMenuData.swift
//  UbiqApp
//
//  Created by iOS Developer on 4/5/17.
//  Copyright © 2017 ubiq. All rights reserved.
//

struct LeftMenuSection {
    var imageName: String!
    var name: String!
    var items: [String]!
    var collapsed: Bool!
    var notificationNumber:String = ""
    
    init(name: String, items: [String], collapsed: Bool = false, notificationNumber: String = "", imageName: String = "") {
        self.name = name
        self.items = items
        self.collapsed = collapsed
        self.notificationNumber = notificationNumber
        self.imageName = imageName
    }
}

