//
//  PopularPopularCollectionMediator.swift
//

import UIKit

class PopularCollectionMediator: NSObject, UITableViewDelegate, UITableViewDataSource {

    var dataCount: Int = 0 {
        didSet {
            tableView?.reloadData()
        }
    }
    
    var fillCellData: ((_ cell: PopularCellViewInput, _ indexPath: IndexPath) -> Void)?
    var cellSelectionClosure: ((_ indexPath: IndexPath) -> Void)?

    init(_ cell: UITableViewCell.Type) {
        self.cell = cell
    }

    private var reuse: String { String(describing: cell) }
    private var cell: UITableViewCell.Type
    private var tableView: UITableView?

    func fillCollection(_ tableView: UITableView?) {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(cell, forCellReuseIdentifier: reuse)
        
        self.tableView = tableView
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuse, for: indexPath) as? PopularTableViewCell else { return UITableViewCell() }

        cell.tag = indexPath.row
        fillCellData?(cell, indexPath)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellSelectionClosure?(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
}
