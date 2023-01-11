//
//  PopularPopularRouter.swift
//

import Foundation

class PopularRouter: PopularRouterInput {

    private weak var router: Routable?
    
    init(router: Routable?) {
        self.router = router
    }
}
