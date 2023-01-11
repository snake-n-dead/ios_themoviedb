//
//  Genre.swift
//

import Foundation

struct Genre {
    var id: Int?
    var name: String?
    
    struct Model {
        var id: Int
        var name: String
    }
    
    var viewModel: Model {
        .init(id: id ?? 0,
              name: name ?? "")
    }
}

extension Genre: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

