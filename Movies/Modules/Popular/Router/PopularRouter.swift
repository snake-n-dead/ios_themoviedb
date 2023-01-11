//
//  PopularPopularRouter.swift
//

import Foundation

class PopularRouter: PopularRouterInput {

    private weak var router: Routable?
    
    init(router: Routable?) {
        self.router = router
    }
    
    func showDetail(movie: Movie.Model) {
        guard let router = router else { return }
        let detailBuilder = DetailBuilder.build(with: router, movie: movie)
        router.push(detailBuilder, animated: true)
    }
}
