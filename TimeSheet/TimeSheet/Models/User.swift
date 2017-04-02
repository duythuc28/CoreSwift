//
//  User.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/2/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//


import Argo
import Runes
import Curry

class User: NSObject, NSCoding {
    let id: Int
    let userName: String
    let firstName: String
    let lastName: String
    let phone: String
    let email: String
    let department: String
    // Memberwise initializer
    init(id: Int, userName: String, firstName: String, lastName: String, phone: String, email: String, department: String) {
        self.id = id
        self.userName = userName
        self.lastName = lastName
        self.firstName = firstName
        self.phone = phone
        self.email = email
        self.department = department
    }
    
    // MARK: - NSCoding 
    required convenience init?(coder decoder: NSCoder) {
        guard let id = decoder.decodeObject(forKey: "id") as? Int,
            let userName = decoder.decodeObject(forKey: "userName") as? String,
            let firstName = decoder.decodeObject(forKey: "firstName") as? String,
            let lastName = decoder.decodeObject(forKey: "lastName") as? String,
            let phone = decoder.decodeObject(forKey: "phone") as? String,
            let email = decoder.decodeObject(forKey: "email") as? String,
            let department = decoder.decodeObject(forKey: "department") as? String
            else { return nil }
        
        // Init data
        self.init(id: id,
                  userName: userName,
                  firstName: firstName,
                  lastName: lastName,
                  phone: phone,
                  email: email,
                  department: department)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.userName, forKey: "userName")
        aCoder.encode(self.firstName, forKey: "firstName")
        aCoder.encode(self.lastName, forKey: "lastName")
        aCoder.encode(self.phone  , forKey: "phone")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.department, forKey: "department")
    }
}

extension User: Decodable {
    /**
     Decode an object from JSON.
     
     This is the main entry point for Argo. This function declares how the
     conforming type should be decoded from JSON. Since this is a failable
     operation, we need to return a `Decoded` type from this function.
     
     - parameter json: The `JSON` representation of this object
     
     - returns: A decoded instance of the `DecodedType`
     */
    public static func decode(_ json: JSON) -> Decoded<User> {
        return curry(User.init)
        <^> json <| "id"
        <*> json <| "user_name"
        <*> json <| "first_name"
        <*> json <| "last_name"
        <*> json <| "phone"
        <*> json <| "email"
        <*> json <| "department"
    }

}
