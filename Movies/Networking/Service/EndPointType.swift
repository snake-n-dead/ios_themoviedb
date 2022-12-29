//
//  EndPoint.swift
//  NetworkLayer
//
//  Created by Malcolm Kumwenda on 2018/03/05.
//  Copyright © 2018 Malcolm Kumwenda. All rights reserved.
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
        guard let url = URL(string: "http://192.168.1.100:3000/") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var data: Data? { nil }
}
