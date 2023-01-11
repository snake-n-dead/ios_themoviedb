//
//  CastActor.swift
//

import Foundation

struct Credit {
    var id: Int?
    var name: String?
    var profilePath: String?
    var character: String?
    var order: Int?
}

extension Credit: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case character
        case order
    }
}

