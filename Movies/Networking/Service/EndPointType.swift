//
//  EndPoint.swift
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var data: Data? { get }
}

extension EndPointType {
    var baseURL: URL {
        guard let url = URL(string: Constants.baseURL) else {
            fatalError("baseURL could not be configured.")
        }
        return url
    }
    
    var data: Data? { nil }
}
