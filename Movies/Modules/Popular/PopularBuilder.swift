//
//  PopularPopularBuilder.swift
//

import UIKit

class PopularBuilder {

    static func build(router: Routable) -> UIViewController {
        
        let storyboard = UIStoryboard(name: Storyboard.Main, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "PopularViewController") as? PopularViewController else {
            fatalError()
        }
        
        let collectionMediator = PopularCollectionMediator(PopularTableViewCell.self)
        
        let moduleRouter = PopularRouter(router: router)
        let presenter = PopularPresenter(router: moduleRouter, view: viewController, collectionMediator: collectionMediator)

        viewController.output = presenter
        viewController.collectionMediator = collectionMediator
                        
        return viewController
    }
}
