//
//  GenresGenresResponseModel.swift
//

import Foundation

struct GenresResponseModel: Codable {
    var genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}

