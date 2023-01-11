//
//  Message.swift
//

import Foundation

struct Message <T: Codable>: Codable {
    var page: Int?
    var results: T
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(page, forKey: .page)
        try container.encode(results, forKey: .results)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try? container.decode(Int.self, forKey: .page)
        results = try container.decode(T.self, forKey: .results)
    }
}
