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
    
    func login(email: String, password: String, completion: @escaping (_ result: Result<Token>) -> Void) {
        let provider = MoyaProvider<RequestService>()
        provider.request(.login(credential:Credential(email: email, password: password) )) { result in
            switch result {
            case let .success(response):
                if let json = try? response.mapJSON() {
                    if response.statusCode == 200 {
                        guard let dictionary = json as? JSONDictionary, let token = Token(json: dictionary) else
                        {
                            return
                        }
                        completion(.success(token))
                    } else {
                        let errorResponse: ErrorResponse? = decode(json)
                        completion(.failure(errorResponse!))
                    }
                }
                
                break
            case let .failure(error):
                if let json = try? error.response?.mapJSON(), let j: Any = json {
                    guard let errorResponse: ErrorResponse = decode(j) else { return }
                    completion(.failure(errorResponse))
                }
                break
            }
        }
    }
    
}
