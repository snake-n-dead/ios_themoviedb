//
//  Router.swift
//

import UIKit

typealias RouterCompletions = [UIViewController: Closure]

final class Router: NSObject {
    
    fileprivate weak var rootController: UINavigationController?
    fileprivate var completions: RouterCompletions
    
    init(rootController: UINavigationController) {
        self.rootController = rootController
        completions = [:]
    }
    
    var toPresent: UIViewController? {
        return rootController
    }
}

private extension Router {
    func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
}

// MARK: - Routable methods
extension Router: Routable {
    
    func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }
    
    func push(_ module: Presentable?, animated: Bool, completion: Closure?) {
        guard
            let controller = module?.toPresent,
            !(controller is UINavigationController)
            else { assertionFailure("⚠️Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.pushViewController(controller, animated: animated)
    }
    
    func popModule(animated: Bool)  {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    func dismissModule(animated: Bool, completion: Closure?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func setRootModule(_ module: Presentable?, hideBar: Bool) {
        guard let controller = module?.toPresent else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }
    
    func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }
}
