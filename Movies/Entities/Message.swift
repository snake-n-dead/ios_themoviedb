//
//  Message.swift
//  Movies
//
//  Created by Vladimir Vasilyev on 29.12.2022.
//

import Foundation

struct Message <T: Codable>: Codable {
    var success: Bool
    var message: T
    
    enum CodingKeys: String, CodingKey {
        case success
        case message
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(success, forKey: .success)
        try container.encode(message, forKey: .message)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        success = try container.decode(Bool.self, forKey: .success)
        message = try container.decode(T.self, forKey: .message)
    }
}
