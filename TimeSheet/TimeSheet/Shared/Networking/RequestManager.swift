//
//  RequestManager.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/2/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import Moya

struct Token {
    let token: String
}

enum Result<Value> {
    case success(Value)
    case failure(MoyaError)
}

final class RequestManager {
    private init () {
        
    }
    // MARK: - Shared Instance
    static let sharedInstance: RequestManager = RequestManager()
    // MARK: - Method
    func login(with email: String, password: String, completion: (_ result: Result<Token>) -> Void) {
        let provider = MoyaProvider<RequestService>()
        let credential = Credential(email: email, password: password)
        provider.request(.login(credential:credential )) { result in
            switch result {
            case let .success(response):
//                let token = response.mapJSON()
//                completion(Token())
                break
            case let .failure(error):
                break
            }
        }
    }
    
}
