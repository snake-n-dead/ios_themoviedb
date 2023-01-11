//
//  PopularPopularPresenter.swift
//

import Foundation

class PopularPresenter {

    private weak var collectionMediator: PopularCollectionMediator?
    private weak var view: PopularViewInput?
    
    private let router: PopularRouterInput
    private var interactors = Interactors()

    init(router: PopularRouterInput, view: PopularViewInput?, collectionMediator: PopularCollectionMediator?) {
        self.collectionMediator = collectionMediator
        self.router = router
        self.view = view
        
        setupDependencies()
    }

    private func setupDependencies() {
        collectionMediator?.fillCellData = {
            [weak self]
            (cellInput, indexPath) in
            guard let self_ = self else { return }
        }

        collectionMediator?.cellSelectionClosure = {
            [weak self]
            (indexPath) in
            guard let self_ = self else { return }
        }
    }

    //MARK: - Private

}

//MARK: PopularViewOutput methods
extension PopularPresenter: PopularViewOutput {

    func viewOnReady() {
    }

    func viewOnAppear() {

    }
}

private extension PopularPresenter {
}
