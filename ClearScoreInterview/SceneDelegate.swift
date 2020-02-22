//
//  SceneDelegate.swift
//  ClearScoreInterview
//
//  Created by Jérémy TOUZY on 21/02/2020.
//  Copyright © 2020 jtouzy. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard
            let windowScene = scene as? UIWindowScene,
            let firstViewController = CreditScoreAssembler.assemble()
        else { return }
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: firstViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}
