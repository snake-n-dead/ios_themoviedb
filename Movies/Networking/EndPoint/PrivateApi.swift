//
//  PrivateApi.swift
//

import Foundation

public enum PrivateApi {
    case getPopular(page: Int)
    case getGenres
    case getCredits(movieId: String)
}

extension PrivateApi: EndPointType {

    var path: String {
        switch self {
        case .getPopular:
            return "movie/popular"
        case .getGenres:
            return "genre/movie/list"
        case let .getCredits(movieId):
            return "movie/\(movieId)/credits"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getGenres,
                .getCredits,
                .getPopular:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case let .getPopular(page):
            return .requestParametersAndHeaders(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters: apiKey(for: ["page": page]),
                additionHeaders: nil)
        case .getGenres:
            return .requestParametersAndHeaders(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters: apiKey(),
                additionHeaders: nil)
        case let .getCredits(movieId):
            return .requestParametersAndHeaders(
                bodyParameters: nil,
                bodyEncoding: .urlEncoding,
                urlParameters: apiKey(for: ["movie_id": movieId]),
                additionHeaders: nil)
        }
    }
    
    func apiKey(for parameters: Parameters = [:]) -> Parameters {
        var copy = parameters
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? Dictionary<String, AnyObject> else { return copy }
        
        copy[Constants.apiKeyKey] = dict[Constants.apiKeyPlistKey]
        return copy
    }
    
    var headers: HTTPHeaders? { nil }
}
