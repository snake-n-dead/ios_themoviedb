//
//  Movie.swift
//

import Foundation

struct Movie {
    var title: String?
    var voteAverage: Double?
    var isVideo: Bool?
    var voteCount: Int?
    var popularity: Double?
    var backdropPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var id: Int?
    var genreIds: [Int]?
    var releaseDate: String?
    var overview: String?
    var adult: Bool?
    var posterPath: String?
    
    struct Model {
        var title: String
        var voteAverage: Double
        var isVideo: Bool
        var voteCount: Int
        var popularity: Double
        var backdropPath: String
        var originalLanguage: String
        var originalTitle: String
        var id: Int
        var genreIds: [Int]
        var releaseDate: String
        var overview: String
        var adult: Bool
        var posterPath: String
    }
    
    var viewModel: Model {
        .init(title: title ?? "",
              voteAverage: voteAverage ?? 0,
              isVideo: isVideo ?? false,
              voteCount: voteCount ?? 0,
              popularity: popularity ?? 0,
              backdropPath: backdropPath ?? "",
              originalLanguage: originalLanguage ?? "",
              originalTitle: originalTitle ?? "",
              id: id ?? 0,
              genreIds: genreIds ?? [],
              releaseDate: releaseDate ?? "",
              overview: overview ?? "",
              adult: adult ?? false,
              posterPath: posterPath ?? "")
    }
}

extension Movie: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case voteAverage = "vote_average"
        case isVideo = "video"
        case voteCount = "vote_count"
        case popularity
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case id
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case overview
        case adult
        case posterPath = "poster_path"
    }
}
