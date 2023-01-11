//
//  Routable.swift
//

import Foundation

protocol Routable: AnyObject, Presentable {
    func present(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: Closure?)
    func popModule(animated: Bool)
    func dismissModule(animated: Bool, completion: Closure?)
    func setRootModule(_ module: Presentable?, hideBar: Bool)
    func popToRootModule(animated: Bool)
}

extension Routable {
    func present(_ module: Presentable?, animated: Bool = false) {
        self.present(module, animated: animated)
    }
    
    func push(_ module: Presentable?, animated: Bool = false, completion: Closure? = nil) {
        push(module, animated: animated, completion: completion)
    }

    func popModule(animated: Bool = false) {
        popModule(animated: animated)
    }
    
    func dismissModule(animated: Bool = false, completion: Closure? = nil) {
        dismissModule(animated: animated, completion: completion)
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool = false) {
        setRootModule(module, hideBar: hideBar)
    }
    
    func popToRootModule(animated: Bool = false) {
        popToRootModule(animated: animated)
    }
}

protocol RoutableObject: NSObjectProtocol, Routable {}
