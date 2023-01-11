//
//  DetailDetailPresenter.swift
//

import Foundation

class DetailPresenter {
    
    private weak var view: DetailViewInput?
    private var interactors = Interactors()
    private let router: DetailRouterInput
    
    private let movie: Movie.Model
    private var cast: [Credit] = [] { didSet { refreshCast() } }

    init(router: DetailRouterInput,
         movie: Movie.Model,
         view: DetailViewInput) {
        
        self.view = view
        self.router = router
        self.movie = movie
    }
}

//MARK: DetailViewOutput methods
extension DetailPresenter: DetailViewOutput {
    
    func viewOnReady() {
        refreshDetails()
        getCast()
    }

    func viewOnAppear() {

    }
}

//MARK: - Private
private extension DetailPresenter {
    
    func refreshDetails() {
        view?.update(title: movie.title, large: false)
        view?.update(state: .posterURL(movie.posterPath))
        view?.update(state: .overview(movie.overview))
        view?.update(state: .rating(movie.voteAverage))
    }
    
    func getCast() {
        let id = "\(movie.id)"
        interactors.movies.credits.request(movieId: id) {
            [weak self]
            result in
            
            switch result {
            case let .success(response):
                self?.cast = response.cast.sorted(by: { $0.order ?? 0 == $1.order ?? 0 })
            case let .failure(error):
                self?.view?.show(info: .error(response: error))
            }
        }
    }
    
    func refreshCast() {
        var result = ""
        
        for credit in cast {
            result += "\(credit.character ?? ""): \(credit.name ?? "")"
            result += "\n"
        }
        
        view?.update(state: .cast(result))
    }
}
