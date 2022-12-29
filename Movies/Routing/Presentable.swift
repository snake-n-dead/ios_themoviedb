//
//  Presentable.swift
//  Sales
//
//  Created by Vladimir Vasilyev on 28.12.2022.
//

import UIKit

protocol Presentable {
    var toPresent: UIViewController? { get }
}
 
extension UIViewController: Presentable {
    var toPresent: UIViewController? {
        return self
    }
}

protocol BaseViewProtocol: NSObjectProtocol, Presentable {}
