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

typealias JSONDictionary = [String: Any]

struct Credential {
    let email: String
    let password: String
}

struct Token {
    let token: String
}

extension Token {
    init?(json: JSONDictionary) {
        guard let token = json["token"] as? String else {
            return nil
        }
        self.token = token
    }
}


struct ErrorResponse: Decodable {
    let responseMessage: String
    
    static func decode(_ json: JSON) -> Decoded<ErrorResponse> {
        return curry(ErrorResponse.init)
        <^> json <| "message"
    }
}

struct HashtagItem: Decodable {
    let value: String
    static func decode(_ json: JSON) -> Decoded<HashtagItem> {
        return curry(HashtagItem.init)
            <^> json <| "value"
    }

}

struct Hashtag: Decodable {
    let hashtagList: [HashtagItem]
    let maxHashTag: Int
    let dynamicHashTag: Bool
    
    static func decode(_ json: JSON) -> Decoded<Hashtag> {
        return curry(Hashtag.init)
            <^> json <|| "hashtagList"
            <*> json <| "maxhashtag"
            <*> json <| "dynamichashtag"
    }
}

enum MediaType {
    case image, video
}

struct Media {
    
    let name: String
    let file: Data
    let type: MediaType
    init (name: String, file: Data, type: MediaType) {
        self.name = name
        self.file = file
        self.type = type
    }
}

struct UploadMedia: Decodable {
    let name: String
    let url: String
    
    static func decode(_ json: JSON) -> Decoded<UploadMedia> {
        return curry(UploadMedia.init)
            <^> json <| "filename"
            <*> json <| "href"
    }
}
