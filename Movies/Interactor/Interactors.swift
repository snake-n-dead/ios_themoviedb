//
//  Interactors.swift
//

import Foundation

struct Interactors {
    lazy var movies = Movies()
    lazy var genres = Genres()

    struct Movies {
        lazy var popular = PopularInteractor()
        lazy var credits = CreditsInteractor()
    }
    
    struct Genres {
        lazy var list = GenresInteractor()
    }
}
