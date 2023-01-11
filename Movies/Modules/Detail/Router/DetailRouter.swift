//
//  DetailDetailRouter.swift
//  movies
//
//  Created by Vladimir Vassilyev on 29/12/2022.
//  Copyright © 2022 Vladimir. All rights reserved.
//

import Foundation

class DetailRouter: DetailRouterInput {

    private weak var router: Routable?
    
    init(router: Routable) {
        self.router = router
    }
}
