//
//  DetailDetailBuilder.swift
//

import UIKit

class DetailBuilder {

    static func build(with router: Routable,
                      movie: Movie.Model) -> UIViewController {
        
        let storyboard = UIStoryboard(name: Storyboard.Main, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let moduleRouter = DetailRouter(router: router)
        let presenter = DetailPresenter(router: moduleRouter, movie: movie, view: viewController)
        
        viewController.output = presenter
        
        return viewController
    }
}
