//
//  Presentable.swift
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
