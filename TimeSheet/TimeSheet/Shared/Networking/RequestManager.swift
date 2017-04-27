//
//  RequestManager.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/2/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import Moya
import Argo

private let genericError = ErrorResponse(responseMessage: "Network error. Please try again later")

enum Result<Value> {
    case success(Value)
    case failure(ErrorResponse)
}

// Custom closure to add http headers to endpoints
let endpointClosure = { (target: RequestService) -> Endpoint<RequestService> in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let sampleDataClosure: () -> EndpointSampleResponse = { .networkResponse(200, target.sampleData) }
    var endpoint = Endpoint<RequestService>(url: url, sampleResponseClosure: sampleDataClosure, method: target.method, parameters: target.parameters)
    if let headers = target.headers {
        endpoint = endpoint.adding(newHTTPHeaderFields: headers)
    }
    return endpoint
}

let provider = MoyaProvider<RequestService>(endpointClosure: endpointClosure)

final class RequestManager {
    private init () {}
    
    // MARK: - Shared Instance
    static let shared: RequestManager = RequestManager()
    
    // MARK: - Request methods
    func login(credential: Credential, completion: @escaping (_ result: Result<Token>) -> Void) {
        provider.request(.login(credential:credential)) { result in
            switch result {
            case let .success(response):
                guard let json = try? response.mapJSON() else {
                    completion(.failure(genericError))
                    return
                }
                if self.isSuccess(statusCode: response.statusCode), let dictionary = json as? JSONDictionary, let token = Token(json: dictionary) {
                    Cached.token = token.token
                    completion(.success(token))
                } else if let errorResponse: ErrorResponse = decode(json) {
                    completion(.failure(errorResponse))
                } else {
                    completion(.failure(genericError))
                }
                break
            case let .failure(error):
                completion(.failure(self.parseError(error)))
                break
            }
        }
    }
    
    func forgotPassword(email: String, completion: @escaping (_ result: Result<String>) -> Void) {
        provider.request(.forgotPassword(email: email)) { result in
            switch result {
            case let .success(response):
                guard let json = try? response.mapJSON() else {
                    completion(.failure(genericError))
                    return
                }
                if self.isSuccess(statusCode: response.statusCode), let dictionary = json as? JSONDictionary, let message = dictionary["message"] as? String {
                    completion(.success(message))
                } else if let errorResponse: ErrorResponse = decode(json) {
                    completion(.failure(errorResponse))
                } else {
                    completion(.failure(genericError))
                }
                break
            case let .failure(error):
                completion(.failure(self.parseError(error)))
                break
            }
        }
    }
    
    func getHashTag(completion: @escaping (_ result: Result<Hashtag>) -> Void) {
        provider.request(.hashtag) { result in
            switch result {
            case let .success(response):
                guard let json = try? response.mapJSON() else {
                    completion(.failure(genericError))
                    return
                }
                if self.isSuccess(statusCode: response.statusCode), let response: Hashtag = decode(json) {
                    completion(.success(response))
                } else if let errorResponse: ErrorResponse = decode(json) {
                    completion(.failure(errorResponse))
                } else {
                    completion(.failure(genericError))
                }
                break
            case let .failure(error):
                completion(.failure(self.parseError(error)))
                break
            }
        }
    }
    
    func uploadMedia(media: Media, completion: @escaping (_ result: Result<UploadMedia>) -> Void) {
        provider.request(.uploadMedia(media: media)) { result in
            switch result {
            case let .success(response):
                guard let json = try? response.mapJSON() else {
                    completion(.failure(genericError))
                    return
                }
                if self.isSuccess(statusCode: response.statusCode), let response: UploadMedia = decode(json) {
                    completion(.success(response))
                } else if let errorResponse: ErrorResponse = decode(json) {
                    completion(.failure(errorResponse))
                } else {
                    completion(.failure(genericError))
                }
                break
            case let .failure(error):
                completion(.failure(self.parseError(error)))
                break
            }
        }
    }
    
    // MARK: - Private methods
    private func isSuccess(statusCode: Int) -> Bool{
        return statusCode == 200
    }
    
    private func parseError(_ error: MoyaError) -> ErrorResponse {
        if let json = try? error.response?.mapJSON(), let j: Any = json, let errorResponse: ErrorResponse = decode(j) {
            return errorResponse
        } else {
            return genericError
        }
    }
    
}
