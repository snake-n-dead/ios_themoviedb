//
//  DetailDetailViewController.swift
//

import UIKit

class DetailViewController: BaseModuleViewController {

    var output: DetailViewOutput?

    //MARK: Props
    
    
    //MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output?.viewOnReady()
    }

    private func setupUI() {
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewOnAppear()
    }
}

private extension DetailViewController {
    
}

//MARK: -

extension DetailViewController: DetailViewInput {
    
}
