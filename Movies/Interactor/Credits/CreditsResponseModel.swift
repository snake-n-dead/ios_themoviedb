//
//  CreditsCreditsResponseModel.swift
//

import Foundation

struct CreditsResponseModel: Codable {
    var id: Int?
    var cast: [Credit]
    
    enum CodingKeys: String, CodingKey {
        case id
        case cast
    }
}

