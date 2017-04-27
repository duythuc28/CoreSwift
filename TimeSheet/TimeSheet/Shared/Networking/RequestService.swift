//
//  RequestService.swift
//  TimeSheet
//
//  Created by iOS Developer on 4/2/17.
//  Copyright © 2017 iOS Developer. All rights reserved.
//

import Moya

enum RequestService {
    case login(credential: Credential)
    case forgotPassword(email: String)
    case hashtag
    case uploadMedia(media: Media)
}

extension RequestService: TargetType {
    var baseURL: URL { return URL(string: APIConstant.BASE_URL)! }
    
    var path: String {
        switch self {
        case .login:
            return "login_check"
        case .forgotPassword:
            return "users/pwd/lost.json"
        case .hashtag:
            return "hashtag/list"
        case .uploadMedia:
            return "media/upload"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .forgotPassword, .uploadMedia:
            return .post
        case .hashtag:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .login(let credential):
            return ["_username" : credential.email, "_password": credential.password]
        case .forgotPassword(let email):
            return ["username": email]
        case .hashtag, .uploadMedia:
            return nil
        }
    }
    var multipartBody: [MultipartFormData]? {
        switch self {
        case .uploadMedia(let media):
            switch media.type {
            case .image:
                return [MultipartFormData(provider: .data(media.file), name: media.name, fileName: "a/jpg",
                                          mimeType: "image/jpeg")]
            case .video:
                return [MultipartFormData(provider: .data(media.file), name: media.name, fileName: "video.mov",
                                          mimeType: "video.mov")]
            }
        default:
            return nil
        }
    }
    
    // Http headers
    var headers: [String: String]? {
        switch self {
        case .login:
            return nil
        case .forgotPassword:
            return nil
        case .hashtag, .uploadMedia:
            return ["Authorization": "Bearer \(Cached.token)"]
        }
    }
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    var sampleData: Data {
        switch self {
        case .forgotPassword:
            return "{\"message\": \"Reset password success\"}".utf8Encoded
        default:
            return "Half measures are as bad as nothing at all.".utf8Encoded
        }
    }
    var task: Task {
        switch self {
        case .uploadMedia:
            if let multipartBody = self.multipartBody {
                return .upload(.multipart(multipartBody))
            }
            return .request
        default:
            return .request
        }
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
