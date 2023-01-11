//
//  PopularPopularResponseModel.swift
//

import Foundation

struct PopularResponseModel: Codable {
    var results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

