//
//  DetailDetailPresenter.swift
//

import Foundation

class DetailPresenter {
    
    private weak var view: DetailViewInput?
    private var interactors = Interactors()
    private let router: DetailRouterInput
    
    private let movie: Movie.Model

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
    }

    func viewOnAppear() {

    }
}

//MARK: - Private
private extension DetailPresenter {
    
}
