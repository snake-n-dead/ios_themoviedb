//
//  SceneDelegate.swift
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var router: Router?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }

        let rootController = UINavigationController()
        rootController.navigationBar.isTranslucent = false
        rootController.view.backgroundColor = .black
        rootController.navigationBar.tintColor = .orange

        let router = Router(rootController: rootController)
        let view = PopularBuilder.build(router: router)
        router.setRootModule(view, hideBar: false)
        self.router = router

        window?.overrideUserInterfaceStyle = .dark
        window?.rootViewController = rootController
    }
}

