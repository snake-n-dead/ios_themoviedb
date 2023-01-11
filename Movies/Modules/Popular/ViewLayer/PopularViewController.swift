//
//  PopularPopularViewController.swift
//

import UIKit
class PopularViewController: BaseModuleViewController {

    var output: PopularViewOutput?
    var collectionMediator: PopularCollectionMediator?

    //MARK: Props
    
    //MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupDependencies()
        output?.viewOnReady()
    }

    private func setupDependencies() {
    }

    private func setupUI() {
    }

    private func setupActions() {
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewOnAppear()
    }
}

//MARK: - PopularViewInput methods

extension PopularViewController: PopularViewInput {

}
