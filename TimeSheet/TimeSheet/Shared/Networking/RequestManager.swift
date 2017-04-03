//
//  RequestManager.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/2/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import Moya
import Argo


enum Result<Value> {
    case success(Value)
    case failure(ErrorResponse)
}

final class RequestManager {
    private init () {
        
    }
    // MARK: - Shared Instance
    static let shared: RequestManager = RequestManager()
    // MARK: - Method
    func login(with email: String, password: String, completion: @escaping (_ result: Result<Token>) -> Void) {
        let provider = MoyaProvider<RequestService>()
        let credential = Credential(email: email, password: password)
        provider.request(.login(credential:credential )) { result in
            switch result {
            case let .success(response):
                if let json = try? response.mapJSON() {
                    if response.statusCode == 200 {
                        let jsonResponse = json as! [String:Any]
                        completion(.success(Token(token:(jsonResponse["token"] as! String))))
                        
                    } else {
                        let errorResponse: ErrorResponse? = decode(json)
                        completion(.failure(errorResponse!))
                    }
                }
                
                break
            case let .failure(error):
                if let json = try? error.response?.mapJSON(), let j: Any = json {
                    let errorResponse: ErrorResponse? = decode(j)
                    completion(.failure(errorResponse!))
                }
                break
            }
        }
    }
    
}
