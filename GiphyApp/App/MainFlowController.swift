//
//  MainFlowController.swift
//  GiphyApp
//
//  Created by Haydar Bekmuradov on 22.02.22.
//

import UIKit

final class MainFlowController: FlowController {
    
    private let rootWindow: UIWindow
    private let tabBarViewController = MainTBC()

    required init(withRoot window: UIWindow) {
        self.rootWindow = window
    }
    
    func start() {
        let favorites = PopularFlowController(withRoot: rootWindow)
        let search = SearchFlowController(withRoot: rootWindow)
        let settings = SettingsFlowController(withRoot: rootWindow)

        favorites.start()
        search.start()
        settings.start()
    
        tabBarViewController.viewControllers = [
            favorites.presentableViewController,
            search.presentableViewController,
            settings.presentableViewController
        ]
        UIView.transition(with: rootWindow, duration: 0.5, options: .transitionFlipFromBottom, animations: nil, completion: nil)
        rootWindow.rootViewController = tabBarViewController
        rootWindow.makeKeyAndVisible()
    }
}

