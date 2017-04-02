//
//  RequestService.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/2/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import Moya

struct Credential {
    let email: String
    let password: String
}

enum RequestService {
    case login(credential : Credential)
}

extension RequestService: TargetType {
    var baseURL: URL { return URL(string: Constants.BASE_URL )! }
    
    var path: String {
        switch self {
        case .login(_):
            return "/login"
        }
    }
    var method: Moya.Method {
        return .post
    }
    var parameters: [String: Any]? {
        switch self {
        case .login(let credential):
            return ["email" : credential.email, "password": credential.password]
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    var sampleData: Data {
        return "Half measures are as bad as nothing at all.".utf8Encoded
    }
    var task: Task {
        return .request
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
