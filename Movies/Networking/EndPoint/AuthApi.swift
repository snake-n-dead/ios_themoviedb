//
//  MovieEndPoint.swift
//  NetworkLayer
//

import Foundation

public enum AuthApi {
    case signin(nickname: String, password: String)
    case signup(nickname: String, password: String, email: String)
    case signout(refreshToken: String)
    case refresh
}

extension AuthApi: EndPointType {

    var path: String {
        switch self {
        case .signin(_, _):
            return "signin"
        case .signup(_, _, _):
            return "signup"
        case .signout(_):
            return "signout"
        case .refresh:
            return "refresh"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .post
    }
    
    var task: HTTPTask {
        switch self {
        case let .signin(nickname, password):
            return .requestParameters(bodyParameters:
                                        ["username": nickname,
                                         "password": password],
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: nil)
        case let .signup(nickname, password, email):
            return .requestParameters(bodyParameters:
                                        ["username": nickname,
                                         "password": password,
                                         "email": email],
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: nil)
        case .refresh:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                bodyEncoding: .jsonEncoding,
                                                urlParameters: nil,
                                                additionHeaders: headers)
        case let .signout(refreshToken):
            return .requestParameters(bodyParameters: ["refreshToken": refreshToken],
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: nil)

        }
    }
    
     var headers: HTTPHeaders? {
         guard let token = Session.refresh else { return nil }
         return ["x-refresh-token": token]
     }
}
