//
//  RequestServiceModel.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/3/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//
import Argo
import Runes
import Curry

struct Credential {
    let email: String
    let password: String
}

struct Token {
    let token: String
}

struct ErrorResponse: Decodable {
    let responseMessage: String
    let status: String
    
    static func decode(_ json: JSON) -> Decoded<ErrorResponse> {
        return curry(ErrorResponse.init)
        <^> json <| "message"
        <*> json <| "status"
    }
}
