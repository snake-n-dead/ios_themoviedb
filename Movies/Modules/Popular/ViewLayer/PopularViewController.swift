//
//  PopularPopularViewController.swift
//

import UIKit
class PopularViewController: BaseModuleViewController {

    var output: PopularViewOutput?
    var collectionMediator: PopularCollectionMediator?

    //MARK: Props
    
    @IBOutlet private weak var searchBar: UISearchBar?
    @IBOutlet private weak var table: UITableView?

    override var scroll: UIScrollView? { table }
    
    //MARK: Init

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        setupDependencies()
        output?.viewOnReady()
    }

    private func setupDependencies() {
        collectionMediator?.fillCollection(table)
    }

    private func setupUI() {
        definesPresentationContext = true
        
        table?.showsVerticalScrollIndicator = false
        table?.bounces = false
        table?.layer.cornerRadius = Constants.corner
        table?.backgroundColor = .white.withAlphaComponent(Alpha.transparent)
    }

    private func setupActions() {
        searchBar?.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewOnAppear()
    }
}

extension PopularViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        output?.changed(searchText: searchText)
    }
}

//MARK: - PopularViewInput methods

extension PopularViewController: PopularViewInput {

}
